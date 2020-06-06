# frozen_string_literal: true

class MatchmakingService
  def call(round)
    clear_round(round)
    create_players(round)
  end

  private

  def clear_round(round)
    round.players.destroy_all
  end

  def create_players(round)
    competitor_ids(round).in_groups(round.tables_count, false).each_with_index.inject([]) do |players, (group, idx)|
      group.inject(players) do |acc, competitor_id|
        acc << round.players.create!(
          competitor_id: competitor_id,
          table_number: idx + 1
        )
      end
    end
  end

  def competitor_ids(round)
    Assigners::RandomAssigner.new.call(round) ||
      Assigners::NewOpponentsAssigner.new.call(round) ||
      Assigners::SwissAssigner.new.call(round)
  end
end
