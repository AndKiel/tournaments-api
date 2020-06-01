# frozen_string_literal: true

class CompetitorForm < Reform::Form
  property :name
  property :tournament_id, writeable: false

  validation do
    option :form

    params do
      required(:name).filled(:str?)
    end

    rule(:name) do
      puts "inside form >>> value: #{value} | tournament_id: #{form.model.tournament_id} | id: #{form.model.id}"
      if Competitor
           .where(name: value, tournament_id: form.model.tournament_id)
           .where.not(id: form.model.id)
           .exists?
        key.failure(I18n.t('errors.messages.taken'))
      end
    end
  end
end
