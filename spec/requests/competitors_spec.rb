require 'rails_helper'

RSpec.describe 'Competitors', type: :request do
  authenticate(:hellen)

  describe 'POST /competitor' do
    context 'when it is possible to enlist' do
      let(:tournament) { tournaments(:tenkaichi_budokai) }

      context 'when params are valid' do
        it 'creates Competitor' do
          expect do
            post competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id,
                   competitor: {
                     name: 'Hellen'
                   }
                 }
          end.to change(Competitor, :count).by(1)
          expect(response).to have_http_status(:created)
          expect(response.body).to match_json_expression(competitor_json)
        end
      end

      context 'when params are not valid' do
        it 'returns validation errors' do
          post competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id,
                 competitor: {
                   name: ''
                 }
               }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to match_json_expression(validation_error_json)
        end
      end
    end

    context 'when it is not possible to enlist' do
      let(:tournament) { tournaments(:in_progress) }

      it 'returns error' do
        post competitor_path,
             headers: auth_headers,
             params: {
               tournament_id: tournament.id
             }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end

  describe 'DELETE /competitor' do
    context 'when it is possible to resign' do
      let(:tournament) { tournaments(:game_of_thrones) }

      it 'deletes Competitor' do
        expect do
          delete competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id
                 }
        end.to change(Competitor, :count).by(-1)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end
    end

    context 'when it is not possible to resign' do
      let(:tournament) { tournaments(:ended) }

      it 'returns error' do
        delete competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id
               }
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end

  context 'when authenticated as tournament organiser' do
    authenticate(:john)

    describe 'POST /competitors/add' do
      context 'when conditions for adding competitor are met' do
        let(:tournament) { tournaments(:tenkaichi_budokai) }

        context 'when params are valid' do
          it 'creates Competitor' do
            expect do
              post add_competitor_path,
                   headers: auth_headers,
                   params: {
                     tournament_id: tournament.id,
                     competitor: {
                       name: 'External'
                     }
                   }
            end.to change(Competitor, :count).by(1)
            expect(response).to have_http_status(:created)
            expect(response.body).to match_json_expression(competitor_json)
          end
        end

        context 'when params are not valid' do
          it 'returns validation errors' do
            post add_competitor_path,
                 headers: auth_headers,
                 params: {
                   tournament_id: tournament.id,
                   competitor: {
                     name: ''
                   }
                 }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to match_json_expression(validation_error_json)
          end
        end
      end

      context 'when conditions for adding competitor are not met' do
        let(:tournament) { tournaments(:in_progress) }

        it 'returns error' do
          post add_competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id
               }
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end

    describe 'DELETE /competitors/:id/remove' do
      context 'when conditions for remove are met' do
        let(:competitor) { competitors(:game_of_thrones_anon) }

        it 'deletes Competitor' do
          delete remove_competitor_path(competitor.id),
                 headers: auth_headers
          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end

      context 'when conditions for remove are not met' do
        let(:competitor) { competitors(:discworld_anon) }

        it 'returns error' do
          delete remove_competitor_path(competitor.id),
                 headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end

    describe 'POST /competitors/:id/confirm' do
      context 'when conditions for confirm are met' do
        let(:competitor) { competitors(:created_hellen) }

        it 'updates Competitor' do
          post confirm_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_expression(competitor_json)
          expect(competitor.reload.status).to eq(:confirmed)
        end
      end

      context 'when conditions for confirm are not met' do
        let(:competitor) { competitors(:in_progress_hellen) }

        it 'returns error' do
          post confirm_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end

    describe 'POST /competitors/:id/reject' do
      context 'when conditions for reject are met' do
        let(:competitor) { competitors(:tenkaichi_budokai_john) }

        it 'updates Competitor' do
          post reject_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:ok)
          expect(response.body).to match_json_expression(competitor_json)
          expect(competitor.reload.status).to eq(:enlisted)
        end
      end

      context 'when conditions for reject are not met' do
        let(:competitor) { competitors(:game_of_thrones_hellen) }

        it 'returns error' do
          post reject_competitor_path(competitor.id),
               headers: auth_headers
          expect(response).to have_http_status(:forbidden)
          expect(response.body).to match_json_expression(error_json)
        end
      end
    end
  end
end
