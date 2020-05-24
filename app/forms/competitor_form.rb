# frozen_string_literal: true

class CompetitorForm < Reform::Form
  property :name
  property :tournament_id, writeable: false

  validation do
    params do
      required(:name).filled(:str?)
    end

    # FIXME: How to access form/model from dry?
    # rule(:name) do
    #   unless Competitor
    #            .where
    #            .not(id: form.model.id)
    #            .where(tournament_id: form.model.tournament_id)
    #            .find_by(name: value)
    #            .nil?
    #     key.failure(:taken)
    #   end
    # end
  end
end
