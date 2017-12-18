require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do
  describe 'GET #index' do
    it 'returns Tournaments', :show_in_doc do
      process :index,
              method: :get
      expect(response).to have_http_status :ok
      expect(response.body).to match_json_expression tournaments_json
    end
  end

  describe 'GET #show' do
    it 'returns Tournament', :show_in_doc do
      process :show,
              method: :get,
              params: {
                id: tournaments(:tenkaichi_budokai).id
              }
      expect(response).to have_http_status :ok
      expect(response.body).to match_json_expression tournament_json
    end
  end

  context 'when authenticated' do
    authenticate(:one)

    describe 'POST #create' do
      context 'params are valid' do
        it 'returns Tournament', :show_in_doc do
          expect do
            process :create,
                    method: :post,
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
            process :create,
                    method: :post,
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

    describe 'PUT #update' do
      context 'params are valid' do
        it 'returns Tournament', :show_in_doc do
          process :update,
                  method: :put,
                  params: {
                    id: tournaments(:tenkaichi_budokai),
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
          process :update,
                  method: :put,
                  params: {
                    id: tournaments(:tenkaichi_budokai),
                    tournament: {
                      competitors_limit: 0
                    }
                  }
          expect(response).to have_http_status :unprocessable_entity
          expect(response.body).to match_json_expression errors_json
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes Tournament', :show_in_doc do
        expect do
          process :destroy,
                  method: :delete,
                  params: {
                    id: tournaments(:delete_me).id
                  }
        end.to change(Tournament, :count).by(-1)
        expect(response).to have_http_status :no_content
        expect(response.body).to be_empty
      end
    end
  end
end
