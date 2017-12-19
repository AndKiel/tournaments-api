require 'rails_helper'

RSpec.describe 'Competitors', type: :request do
  authenticate(:jane_doe)

  describe 'POST /tournaments/:tournament_id/competitor' do
    context 'when it is possible to enlist' do
      let(:tournament) { tournaments(:tenkaichi_budokai) }

      it 'creates Competitor' do
        expect do
          post tournament_competitor_path(tournament.id),
               headers: auth_headers
        end.to change(Competitor, :count).by(1)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end
    end

    context 'when it is not possible to enlist' do
      let(:tournament) { tournaments(:in_progress) }

      it 'returns error' do
        post tournament_competitor_path(tournament.id),
             headers: auth_headers
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end

  describe 'DELETE /tournaments/:tournament_id/competitor' do
    context 'when it is possible to resign' do
      let(:tournament) { tournaments(:game_of_thrones) }

      it 'deletes Competitor' do
        expect do
          delete tournament_competitor_path(tournament.id),
                 headers: auth_headers
        end.to change(Competitor, :count).by(-1)
        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end
    end

    context 'when it is not possible to resign' do
      let(:tournament) { tournaments(:ended) }

      it 'returns error' do
        delete tournament_competitor_path(tournament.id),
               headers: auth_headers
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to match_json_expression(error_json)
      end
    end
  end
end
