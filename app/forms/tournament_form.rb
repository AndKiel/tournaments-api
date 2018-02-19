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

  validates :competitors_limit,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 1
            }

  validates :name,
            presence: true

  validates :result_names,
            presence: true,
            length: {
              minimum: 1
            }

  validates :starts_at,
            presence: true,
            timeliness: {
              after: :now,
              type: :datetime,
              after_message: I18n.t('errors.messages.future_date')
            },
            if: ->(*) { model.status.created? }
end
