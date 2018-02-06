# == Schema Information
#
# Table name: competitors
#
#  created_at    :datetime         not null
#  id            :uuid             not null, primary key
#  name          :string           not null
#  status        :integer          default("enlisted"), not null
#  tournament_id :uuid             not null
#  updated_at    :datetime         not null
#  user_id       :uuid
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
  extend Enumerize

  belongs_to :tournament
  belongs_to :user, optional: true
  has_many :players, dependent: :destroy

  enumerize :status,
            in: {
              enlisted: 0,
              confirmed: 1
            },
            default: :enlisted,
            scope: true
end
