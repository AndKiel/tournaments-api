# frozen_string_literal: true

RSpec.describe 'Results', type: :request do
  describe 'GET /results' do
    let(:tournament) { create(:tournament, :in_progress) }
    let!(:competitors) { create_list(:competitor, 12, :anonymous, :confirmed, tournament: tournament) }
    let!(:first_round) { create(:round, tournament: tournament) }

    before do
      competitors.each_with_index do |competitor, index|
        create(:player, competitor: competitor, result_values: [index % 4], round: first_round)
      end
    end

    it 'returns Results' do
      get results_path,
          params: {
            tournament_id: tournament.id
          }
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema('responses/results')
    end
  end
end
