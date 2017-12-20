class RoundMatcher
  def initialize(round)
    @round = round
    @tournament = round.tournament
    @players = []
  end

  def call
    clear_round
    if is_first_round?
      randomize_players
    else
      assign_players
    end
    @players
  end

  def clear_round
    @round.players.destroy_all
  end

  def randomize_players
    competitor_ids = @tournament.competitors.
      with_status(:confirmed).
      order(created_at: :asc).
      limit(@round.competitors_limit).
      pluck(:id)

    competitor_ids.shuffle!

    competitor_ids.in_groups(@round.tables_count, false).each_with_index do |group, idx|
      group.each do |competitor_id|
        @players << @round.players.create!(
          competitor_id: competitor_id,
          table_number: idx
        )
      end
    end
  end

  def assign_players
    raise NotImplementedError
  end

  def is_first_round?
    @round.id == @tournament.rounds.order(created_at: :asc).first.id
  end
end