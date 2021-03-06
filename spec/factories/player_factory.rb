# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id            :uuid             not null, primary key
#  result_values :integer          default([]), not null, is an Array
#  table_number  :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  competitor_id :uuid             not null
#  round_id      :uuid             not null
#
# Indexes
#
#  index_players_on_competitor_id  (competitor_id)
#  index_players_on_round_id       (round_id)
#
# Foreign Keys
#
#  fk_rails_...  (competitor_id => competitors.id)
#  fk_rails_...  (round_id => rounds.id)
#
FactoryBot.define do
  factory :player do
    table_number { 1 }

    association :competitor
    association :round

    trait :loser do
      result_values { [0] }
    end

    trait :winner do
      result_values { [1] }
    end
  end
end
