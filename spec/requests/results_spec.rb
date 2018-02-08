require 'rails_helper'

RSpec.describe 'Results', type: :request do
  describe 'GET /results' do
    let(:tournament) { tournaments(:gwent) }

    it 'returns Results' do
      get results_path,
          params: {
            tournament_id: tournament.id
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(results_json)
    end
  end
end
