# frozen_string_literal: true

class TournamentForm < Reform::Form
  property :competitors_limit
  property :description
  property :name
  property :result_names,
           populator: lambda { |fragment:, **|
             self.result_names = fragment.reject(&:blank?)
           }
  property :starts_at,
           skip_if: ->(*) { !model.status.created? }

  validation do
    params do
      required(:competitors_limit).filled(:int?, gt?: 1)
      required(:name).filled(:str?)
      required(:result_names).filled(:array?).each(:str?)
    end
  end

  # TODO: How to port conditional validation?
  # validates :starts_at,
  #           presence: true,
  #           timeliness: {
  #             after: :now,
  #             type: :datetime,
  #             after_message: I18n.t('errors.messages.future_date')
  #           },
  #           if: ->(*) { model.status.created? }
end
