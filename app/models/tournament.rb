# == Schema Information
#
# Table name: tournaments
#
#  competitors_limit :integer          not null
#  created_at        :datetime         not null
#  description       :text             default(""), not null
#  id                :uuid             not null, primary key
#  name              :text             not null
#  organiser_id      :uuid             not null
#  starts_at         :datetime
#  status            :integer          default(0), not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_tournaments_on_organiser_id  (organiser_id)
#
# Foreign Keys
#
#  fk_rails_...  (organiser_id => users.id)
#

class Tournament < ApplicationRecord
  belongs_to :organiser, class_name: 'User'
  has_many :rounds
end
