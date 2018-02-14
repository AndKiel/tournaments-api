require 'rails_helper'

RSpec.describe 'Tournaments', type: :request do
  describe 'GET /tournaments' do
    it 'returns Tournaments' do
      get tournaments_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(tournaments_json)
      expect(response.body).to match_json_expression(pagination_meta_json)
    end

    it 'allows filtering' do
      expect(Tournament).to receive(:starts_at_after).and_call_original
      expect(Tournament).to receive(:with_name).and_call_original
      get tournaments_path,
          params: {
            filters: {
              starts_at_after: 1.day.since,
              with_name: ''
            }
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(tournaments_json)
      expect(response.body).to match_json_expression(pagination_meta_json)
    end

    context 'when authenticated' do
      authenticate(:john)

      it 'returns organised Tournaments' do
        get tournaments_path,
            headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_expression(tournaments_json)
        expect(response.body).to match_json_expression(pagination_meta_json)
      end
    end
  end

  describe 'GET /tournaments/enlisted' do
    authenticate(:andrew)

    it 'returns Tournaments user has enlisted in' do
      get enlisted_tournaments_path,
          headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(tournaments_json)
      expect(response.body).to match_json_expression(pagination_meta_json)
    end

    it 'allows filtering' do
      expect(Tournament).to receive(:starts_at_after).and_call_original
      expect(Tournament).to receive(:with_name).and_call_original
      get tournaments_path,
          params: {
            filters: {
              starts_at_after: 1.day.since,
              with_name: ''
            }
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(tournaments_json)
      expect(response.body).to match_json_expression(pagination_meta_json)
    end
  end

  describe 'GET /tournaments/:id' do
    let(:tournament) { tournaments(:gwent) }
    let(:tournament_detailed_json) do
      {
        tournament: tournament_json[:tournament].merge(
          competitors: competitors_json[:competitors],
          rounds: [
            round_json[:round].merge(
              players: [player_json[:player]].ignore_extra_values!
            )
          ].ignore_extra_values!
        )
      }
    end

    it 'returns Tournament' do
      get tournament_path(tournament.id)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(tournament_detailed_json)
    end
  end

  context 'when authenticated' do
    authenticate(:john)

    describe 'POST /tournaments' do
      context 'when params are valid' do
        it 'returns Tournament' do
          expect do
            post tournaments_path,
                 headers: auth_headers,
                 params: {
                   tournament: {
                     competitors_limit: 8,
                     name: 'New tournament test',
                     result_names: ['Win'],
                     starts_at: 14.days.since
                   }
                 }
          end.to change(Tournament, :count).by(1)
          expect(response).to have_http_status(:created)
          expect(response.body).to match_json_expression(tournament_json)
        end
      end

      context 'when params are not valid' do
        it 'returns validation errors' do
          expect do
            post tournaments_path,
                 headers: auth_headers,
                 params: {
                   tournament: {
                     name: 'New tournament test'
                   }
                 }
          end.to_not change(Tournament, :count)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_expression(validation_error_json)
        end
      end
    end

    describe 'PUT /tournaments/:id' do
      let(:tournament) { tournaments(:tenkaichi_budokai) }

      context 'when params are valid' do
        it 'returns Tournament' do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 16
                }
              }
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_expression(tournament_json)
        end
      end

      context 'when params are not valid' do
        it 'return validation errors' do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 0
                }
              }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_expression(validation_error_json)
        end
      end
    end

    describe 'DELETE /tournaments/:id' do
      let(:tournament) { tournaments(:delete_me) }

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
        let(:tournament) { tournaments(:created) }

        it 'starts Tournament' do
          post start_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_expression(tournament_json)
          expect(tournament.reload.status).to eq(:in_progress)
        end
      end

      context 'when conditions for start are not met' do
        let(:tournament) { tournaments(:in_progress) }

        it 'returns error' do
          post start_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end

    describe 'POST /tournaments/:id/end' do
      context 'when conditions for end are met' do
        let(:tournament) { tournaments(:in_progress) }

        it 'ends Tournament' do
          post end_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_expression(tournament_json)
          expect(tournament.reload.status).to eq(:ended)
        end
      end

      context 'when conditions for end are not met' do
        let(:tournament) { tournaments(:ended) }

        it 'returns error' do
          post end_tournament_path(tournament.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end
  end
end
