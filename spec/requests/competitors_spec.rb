require 'rails_helper'

RSpec.describe 'Competitors', type: :request do
  authenticate(:jane_doe)

  describe 'POST /competitor' do
    context 'when it is possible to enlist' do
      let(:tournament) { tournaments(:tenkaichi_budokai) }

      it 'creates Competitor' do
        expect do
          post competitor_path,
               headers: auth_headers,
               params: {
                 tournament_id: tournament.id
               }
        end.to change(Competitor, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_expression(competitor_json)
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
        expect(response.body).to match_json_expression(forbidden_error_json)
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
        expect(response.body).to match_json_expression(forbidden_error_json)
      end
    end
  end

  describe 'POST /competitors/:id/confirm' do
    authenticate(:john_smith)

    context 'when conditions for confirm are met' do
      let(:competitor) { competitors(:created_jane_doe) }

      it 'updates Competitor' do
        post confirm_competitor_path(competitor.id),
             headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_expression(competitor_json)
        expect(competitor.reload.status).to eq(:confirmed)
      end
    end

    context 'when conditions for confirm are not met' do
      let(:competitor) { competitors(:in_progress_jane_doe) }

      it 'returns error' do
        post confirm_competitor_path(competitor.id),
             headers: auth_headers
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_expression(forbidden_error_json)
      end
    end
  end
end
