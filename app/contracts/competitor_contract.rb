# frozen_string_literal: true

class CompetitorContract < ApplicationContract
  option :model

  json do
    required(:name).filled(:str?)
  end

  rule(:name) do
    if Competitor
         .where(name: value, tournament_id: model.tournament_id)
         .where.not(id: model.id)
         .exists?
      key.failure(I18n.t('errors.messages.taken'))
    end
  end
end
