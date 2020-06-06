# frozen_string_literal: true

module Assigners
  class NewOpponentsAssigner
    def call(round)
      elimination_rounds = round.tournament.rounds
                             .where(competitors_limit: round.competitors_limit, tables_count: round.tables_count)
                             .all
      elimination_index = elimination_rounds.find_index(round)

      return false unless elimination_index.positive?

      round_competitor_ids(elimination_rounds, elimination_index)
    end

    private

    def round_competitor_ids(elimination_rounds, elimination_index)
      competitor_ids = elimination_rounds.first.players.pluck(:competitor_id)

      group_size = Math.sqrt(competitor_ids.size).ceil
      matrix = competitor_ids.in_groups_of(group_size)

      (0..(group_size - 1)).inject([]) do |next_competitor_ids, column|
        (0..(matrix.size - 1)).inject(next_competitor_ids) do |acc, row|
          modified_column = (column + row * elimination_index) % group_size
          id = matrix[row][modified_column]
          acc.push(id) unless id.nil?
        end
      end
    end
  end
end
