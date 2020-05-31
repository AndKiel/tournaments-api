# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Players', type: :request do
  authenticate

  let(:tournament) { create(:tournament, :in_progress, organiser: current_user) }
  let!(:competitors) { create_list(:competitor, 12, :anonymous, :confirmed, tournament: tournament) }
  let!(:first_round) { create(:round, tournament: tournament) }

  describe 'POST /players' do
    context 'with first Round of a Tournament' do
      it 'randomizes Players' do
        expect_any_instance_of(MatchmakingService).to receive(:random_assignment).and_call_original
        expect do
          post players_path,
               headers: auth_headers,
               params: {
                 round_id: first_round.id
               }
        end.to change(Player, :count).by(first_round.competitors_limit)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema('responses/players')
      end
    end

    context 'with consecutive elimination Round of a Tournament' do
      before do
        competitors.each do |competitor|
          create(:player, competitor: competitor, round: first_round)
        end
      end

      let(:second_round) { create(:round, tournament: tournament) }

      it "assigns Players who haven't met yet" do
        expect_any_instance_of(MatchmakingService).to receive(:new_opponents_assignment).and_call_original
        expect do
          post players_path,
               headers: auth_headers,
               params: {
                 round_id: second_round.id
               }
        end.to change(Player, :count).by(second_round.competitors_limit)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema('responses/players')
      end
    end

    context 'with noninitial Round of a Tournament' do
      before do
        competitors.each_with_index do |competitor, index|
          create(:player, competitor: competitor, result_values: [index % 4], round: first_round)
        end
      end

      let(:second_round) { create(:round, competitors_limit: 8, tournament: tournament) }

      it 'assigns Players according to their results' do
        expect_any_instance_of(MatchmakingService).to receive(:swiss_assignment).and_call_original
        expect do
          post players_path,
               headers: auth_headers,
               params: {
                 round_id: second_round.id
               }
        end.to change(Player, :count).by(second_round.competitors_limit)
        expect(response).to have_http_status(:created)
        expect(response.body).to match_json_schema('responses/players')
      end
    end
  end

  describe 'PATCH /players/:id' do
    let!(:player) { create(:player, competitor: competitors.first, round: first_round) }

    context 'with valid params' do
      it 'returns Player' do
        patch player_path(player.id),
              headers: auth_headers,
              params: {
                player: {
                  result_values: [1]
                }
              }
        expect(response).to have_http_status(:ok)
        expect(response.body).to match_json_schema('responses/player')
      end
    end

    context 'with invalid params' do
      it 'returns validation errors' do
        patch player_path(player.id),
              headers: auth_headers,
              params: {
                player: {
                  result_values: []
                }
              }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match_json_schema('responses/validation_error')
      end
    end
  end
end
