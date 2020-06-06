# frozen_string_literal: true

RSpec.describe 'Tournaments', type: :request do
  describe 'GET /tournaments' do
    before { create_list(:tournament, 5) }

    it 'returns Tournaments' do
      get tournaments_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/tournaments')
    end

    it 'allows filtering' do
      expect(Tournament).to receive(:starts_at_after).and_call_original
      expect(Tournament).to receive(:with_name).and_call_original
      get tournaments_path,
          params: {
            filters: {
              starts_at_after: 1.day.since.iso8601,
              with_name: ''
            }
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/tournaments')
    end

    context 'when authenticated' do
      authenticate

      before { create_list(:tournament, 2, organiser: current_user) }

      it 'returns organised Tournaments' do
        get tournaments_path,
            headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('responses/tournaments')
      end
    end
  end

  describe 'GET /tournaments/enlisted' do
    authenticate

    before do
      tournament = create(:tournament)
      create(:competitor, tournament: tournament, user: current_user)
    end

    it 'returns Tournaments user has enlisted in' do
      get enlisted_tournaments_path,
          headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/tournaments')
    end

    it 'allows filtering' do
      expect(Tournament).to receive(:starts_at_after).and_call_original
      expect(Tournament).to receive(:with_name).and_call_original
      get tournaments_path,
          params: {
            filters: {
              starts_at_after: 1.day.since.iso8601,
              with_name: ''
            }
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/tournaments')
    end
  end

  describe 'GET /tournaments/:id' do
    let!(:tournament) { create(:tournament) }

    before do
      competitor = create(:competitor, :anonymous, tournament: tournament)
      round = create(:round, tournament: tournament)
      create(:player, competitor: competitor, round: round)
    end

    it 'returns Tournament' do
      get tournament_path(tournament.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/tournament_extended')
    end
  end

  context 'when authenticated' do
    authenticate

    describe 'POST /tournaments' do
      context 'with valid params' do
        it 'returns Tournament' do
          expect do
            post tournaments_path,
                 headers: auth_headers,
                 params: {
                   tournament: {
                     competitors_limit: 8,
                     name: 'New tournament test',
                     result_names: ['Win'],
                     starts_at: 14.days.since.iso8601
                   }
                 },
                 as: :json
          end.to change(Tournament, :count).by(1)
          expect(response).to have_http_status(:created)
          expect(response.body).to match_json_schema('responses/tournament')
        end
      end

      context 'with invalid params' do
        it 'returns validation errors' do
          expect do
            post tournaments_path,
                 headers: auth_headers,
                 params: {
                   tournament: {
                     name: 'New tournament test'
                   }
                 },
                 as: :json
          end.not_to change(Tournament, :count)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end

    describe 'PUT /tournaments/:id' do
      let(:tournament) { create(:tournament, organiser: current_user) }

      context 'with valid params' do
        it 'returns Tournament' do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 16
                }
              },
              as: :json
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/tournament')
        end
      end

      context 'with invalid params' do
        it 'return validation errors' do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 0
                }
              },
              as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_schema('responses/error')
        end
      end

      context 'when tournament does not have created status' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }

        it 'skips starts at during update' do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  starts_at: 'whatever'
                }
              },
              as: :json
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/tournament')
        end
      end
    end

    describe 'DELETE /tournaments/:id' do
      let!(:tournament) { create(:tournament, organiser: current_user) }

      it 'deletes Tournament' do
        expect do
          delete tournament_path(tournament.id),
                 headers: auth_headers
        end.to change(Tournament, :count).by(-1)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end
    end

    describe 'POST /tournaments/:id/start' do
      context 'when conditions for start are met' do
        let(:tournament) { create(:tournament, :past, organiser: current_user) }

        it 'starts Tournament' do
          post start_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/tournament')
          expect(tournament.reload.status).to eq('in_progress')
        end
      end

      context 'when conditions for start are not met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }

        it 'returns error' do
          post start_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end

    describe 'POST /tournaments/:id/end' do
      context 'when conditions for end are met' do
        let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }

        it 'ends Tournament' do
          post end_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_schema('responses/tournament')
          expect(tournament.reload.status).to eq('ended')
        end
      end

      context 'when conditions for end are not met' do
        let(:tournament) { create(:tournament, :ended, organiser: current_user) }

        it 'returns error' do
          post end_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_schema('responses/error')
        end
      end
    end
  end
end
