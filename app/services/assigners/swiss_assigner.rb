# frozen_string_literal: true

module Assigners
  class SwissAssigner
    def call(round)
      round.tournament.results
        .limit(round.competitors_limit)
        .pluck(:competitor_id)
    end
  end
end
