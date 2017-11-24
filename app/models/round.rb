# == Schema Information
#
# Table name: rounds
#
#  competitors_limit :integer          not null
#  created_at        :datetime         not null
#  id                :uuid             not null, primary key
#  number            :integer          not null
#  tables_count      :integer          not null
#  tournament_id     :uuid             not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_rounds_on_tournament_id  (tournament_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#

class Round < ApplicationRecord
  belongs_to :tournament
end
