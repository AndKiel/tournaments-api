# frozen_string_literal: true

# == Schema Information
#
# Table name: competitors
#
#  id            :uuid             not null, primary key
#  name          :string           not null
#  status        :integer          default("enlisted"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tournament_id :uuid             not null
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
  belongs_to :tournament
  belongs_to :user, optional: true
  has_many :players, dependent: :destroy

  enum status: {
    enlisted: 0,
    confirmed: 1
  }
end
