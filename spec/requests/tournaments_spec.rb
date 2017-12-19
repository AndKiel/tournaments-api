require 'rails_helper'

RSpec.describe 'Tournaments', type: :request do
  describe 'GET /tournaments' do
    it 'returns Tournaments', :show_in_doc do
      get tournaments_path
      expect(response).to have_http_status :ok
      expect(response.body).to match_json_expression tournaments_json
    end

    context 'when authenticated' do
      authenticate(:john_smith)

      it 'returns organized Tournaments', :show_in_doc do
        get tournaments_path,
            headers: auth_headers
        expect(response).to have_http_status :ok
        expect(response.body).to match_json_expression tournaments_json
      end
    end
  end

  describe 'GET /tournaments/:id' do
    let(:tournament) { tournaments(:tenkaichi_budokai) }

    it 'returns Tournament', :show_in_doc do
      get tournament_path(tournament.id)
      expect(response).to have_http_status :ok
      expect(response.body).to match_json_expression tournament_json
    end
  end

  context 'when authenticated' do
    authenticate(:john_smith)

    describe 'POST /tournaments' do
      context 'params are valid' do
        it 'returns Tournament', :show_in_doc do
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
          expect(response).to have_http_status :created
          expect(response.body).to match_json_expression tournament_json
        end
      end

      context 'params are not valid' do
        it 'returns validation errors', :show_in_doc do
          expect do
            post tournaments_path,
                 headers: auth_headers,
                 params: {
                   tournament: {
                     name: 'New tournament test'
                   }
                 }
          end.to_not change(Tournament, :count)
          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to match_json_expression errors_json
        end
      end
    end

    describe 'PUT /tournaments/:id' do
      let(:tournament) { tournaments(:tenkaichi_budokai) }

      context 'params are valid' do
        it 'returns Tournament', :show_in_doc do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 16
                }
              }
          expect(response).to have_http_status :ok
          expect(response.body).to match_json_expression tournament_json
        end
      end

      context 'params are not valid' do
        it 'return validation errors', :show_in_doc do
          put tournament_path(tournament.id),
              headers: auth_headers,
              params: {
                tournament: {
                  competitors_limit: 0
                }
              }
          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to match_json_expression errors_json
        end
      end
    end

    describe 'DELETE /tournaments/:id' do
      let(:tournament) { tournaments(:delete_me) }

      it 'deletes Tournament', :show_in_doc do
        expect do
          delete tournament_path(tournament.id),
                 headers: auth_headers
        end.to change(Tournament, :count).by(-1)
        expect(response).to have_http_status :no_content
        expect(response.body).to be_empty
      end
    end
  end
end
