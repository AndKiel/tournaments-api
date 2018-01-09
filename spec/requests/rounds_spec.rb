require 'rails_helper'

RSpec.describe 'Rounds', type: :request do
  authenticate(:john)

  describe 'POST /rounds' do
    let(:tournament) { tournaments(:tenkaichi_budokai) }

    context 'when params are valid' do
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
               }
        end.to change(Round, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_expression(round_json)
      end
    end

    context 'when params are not valid' do
      it 'returns validation errors' do
        post rounds_path,
             headers: auth_headers,
             params: {
               tournament_id: tournament.id,
               round: {
                 competitors_limit: 0,
                 tables_count: 0
               }
             }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_expression(validation_error_json)
      end
    end
  end

  describe 'PATCH /rounds/:id' do
    let(:round) { rounds(:tenkaichi_budokai_one) }

    context 'when params are valid' do
      it 'returns Round' do
        patch round_path(round.id),
              headers: auth_headers,
              params: {
                round: {
                  competitors_limit: 16,
                  tables_count: 8
                }
              }
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_expression(round_json)
        expect(round.attributes).to_not eq(round.reload.attributes)
      end
    end

    context 'when params are not valid' do
      it 'returns validation errors' do
        patch round_path(round.id),
              headers: auth_headers,
              params: {
                round: {
                  competitors_limit: 0,
                  tables_count: 0
                }
              }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_expression(validation_error_json)
      end
    end
  end

  describe 'DELETE /rounds/:id' do
    let(:round) { rounds(:game_of_thrones_delete_me) }

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
