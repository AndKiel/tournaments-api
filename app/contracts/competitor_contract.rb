# frozen_string_literal: true

class CompetitorContract < ApplicationContract
  option :model

  json do
    required(:name).value(:str?, :filled?)
  end

  rule(:name) do
    if Competitor
         .where(name: value, tournament_id: model.tournament_id)
         .where.not(id: model.id)
         .exists?
      key.failure(:unique?)
    end
  end
end
