# == Schema Information
#
# Table name: competitors
#
#  created_at    :datetime         not null
#  id            :uuid             not null, primary key
#  status        :integer          default(0), not null
#  tournament_id :uuid             not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_competitors_on_tournament_id  (tournament_id)
#  index_competitors_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#  fk_rails_...  (user_id => users.id)
#

class Competitor < ApplicationRecord
  belongs_to :tournament
  belongs_to :user
  has_many :players, dependent: :destroy
end
