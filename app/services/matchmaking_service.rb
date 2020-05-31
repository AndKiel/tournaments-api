# frozen_string_literal: true

# TODO: Split assignment into specific implementations and clean up?
class MatchmakingService
  def initialize(round)
    @round = round
    @tournament = round.tournament
    @players = []
  end

  def call
    clear_round
    if first_round?
      random_assignment
    elsif elimination_round?
      new_opponents_assignment
    else
      swiss_assignment
    end
    @players
  end

  private

  def clear_round
    @round.players.destroy_all
  end


  def first_round?
    @round.id == @tournament.rounds.first.id
  end

  def random_assignment
    competitor_ids = @tournament.competitors
                       .confirmed
                       .limit(@round.competitors_limit)
                       .pluck(:id)
    competitor_ids.shuffle!
    create_players(competitor_ids)
  end


  def elimination_round?
    @elimination_rounds = @tournament.rounds
                            .where(competitors_limit: @round.competitors_limit, tables_count: @round.tables_count)
                            .all
    @elimination_index = @elimination_rounds.find_index(@round)
    @elimination_index.positive?
  end

  def new_opponents_assignment
    competitor_ids = @elimination_rounds.first.players.pluck(:competitor_id)

    group_size = Math.sqrt(competitor_ids.size).ceil
    matrix = competitor_ids.in_groups_of(group_size)
    next_competitor_ids = []

    (0..(group_size - 1)).each do |column|
      (0..(matrix.size - 1)).each do |row|
        modified_column = (column + row * @elimination_index) % group_size
        id = matrix[row][modified_column]
        next_competitor_ids.push(id) unless id.nil?
      end
    end

    create_players(next_competitor_ids)
  end


  def swiss_assignment
    competitor_ids = @tournament.results
                       .limit(@round.competitors_limit)
                       .pluck(:competitor_id)
    create_players(competitor_ids)
  end


  def create_players(competitor_ids)
    competitor_ids.in_groups(@round.tables_count, false).each_with_index do |group, idx|
      group.each do |competitor_id|
        @players << @round.players.create!(
          competitor_id: competitor_id,
          table_number: idx + 1
        )
      end
    end
  end
end
