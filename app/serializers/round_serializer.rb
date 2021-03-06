# frozen_string_literal: true

# == Schema Information
#
# Table name: rounds
#
#  id                :uuid             not null, primary key
#  competitors_limit :integer          not null
#  tables_count      :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  tournament_id     :uuid             not null
#
# Indexes
#
#  index_rounds_on_tournament_id  (tournament_id)
#
# Foreign Keys
#
#  fk_rails_...  (tournament_id => tournaments.id)
#

class RoundSerializer < Blueprinter::Base
  identifier :id

  fields :competitors_limit,
         :created_at,
         :tables_count

  view :extended do
    association :players, blueprint: PlayerSerializer
  end
end
