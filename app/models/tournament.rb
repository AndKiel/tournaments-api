# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id                :uuid             not null, primary key
#  competitors_limit :integer          not null
#  description       :text             default(""), not null
#  name              :string           not null
#  result_names      :string           not null, is an Array
#  starts_at         :datetime
#  status            :integer          default("created"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  organiser_id      :uuid             not null
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
  include TournamentFilters
  extend Enumerize

  belongs_to :organiser, class_name: 'User', inverse_of: :tournaments
  has_many :competitors, -> { order(:created_at) }, inverse_of: :tournament, dependent: :destroy
  has_many :results
  has_many :rounds, -> { order(:created_at) }, inverse_of: :tournament, dependent: :destroy

  enumerize :status,
            in: {
              created: 0,
              in_progress: 1,
              ended: 2
            },
            default: :created,
            scope: true
end
