# frozen_string_literal: true

module Assigners
  class RandomAssigner
    def call(round)
      return false unless valid?(round)

      round.tournament.competitors
        .confirmed
        .limit(round.competitors_limit)
        .pluck(:id)
        .shuffle!
    end

    private

    def valid?(round)
      round.id == round.tournament.rounds.first.id
    end
  end
end
