# == Schema Information
#
# Table name: players
#
#  competitor_id :uuid             not null
#  created_at    :datetime         not null
#  id            :uuid             not null, primary key
#  result_values :integer          not null, is an Array
#  round_id      :uuid             not null
#  table_number  :integer          not null
#  updated_at    :datetime         not null
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

class Player < ApplicationRecord
  belongs_to :competitor
  belongs_to :round
end
