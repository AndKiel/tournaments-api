# frozen_string_literal: true

RSpec.describe 'Rounds', type: :request do
  authenticate

  let(:tournament) { create(:tournament, organiser: current_user) }

  describe 'POST /rounds' do
    context 'with valid params' do
      it 'returns Round' do
        expect do
          post rounds_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id,
                 round: {
                   competitors_limit: 4,
                   tables_count: 2
                 }
               },
               as: :json
        end.to change(Round, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema('responses/round')
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        post rounds_path,
             headers: auth_headers,
             params: {
               tournament_id: tournament.id,
               round: {
                 competitors_limit: 0,
                 tables_count: 0
               }
             },
             as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_schema('responses/error')
      end
    end
  end

  describe 'PATCH /rounds/:id' do
    let!(:round) { create(:round, tournament: tournament) }

    context 'with valid params' do
      it 'returns Round' do
        patch round_path(round.id),
              headers: auth_headers,
              params: {
                round: {
                  competitors_limit: 16,
                  tables_count: 8
                }
              },
              as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('responses/round')
        expect(round.attributes).not_to eq(round.reload.attributes)
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        patch round_path(round.id),
              headers: auth_headers,
              params: {
                round: {
                  competitors_limit: 0,
                  tables_count: 0
                }
              },
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_schema('responses/error')
      end
    end
  end

  describe 'DELETE /rounds/:id' do
    let!(:round) { create(:round, tournament: tournament) }

    it 'returns nothing' do
      expect do
        delete round_path(round.id),
               headers: auth_headers
      end.to change(Round, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end
end
