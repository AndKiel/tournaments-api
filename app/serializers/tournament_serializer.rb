# == Schema Information
#
# Table name: tournaments
#
#  competitors_limit :integer          not null
#  created_at        :datetime         not null
#  description       :text             default(""), not null
#  id                :uuid             not null, primary key
#  name              :string           not null
#  organiser_id      :uuid             not null
#  result_names      :string           not null, is an Array
#  starts_at         :datetime
#  status            :integer          default("created"), not null
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

class TournamentSerializer < ActiveModel::Serializer
  attributes :competitors_limit,
             :description,
             :id,
             :name,
             :organiser_id,
             :result_names,
             :starts_at,
             :status

  has_many :competitors
  has_many :rounds
end
