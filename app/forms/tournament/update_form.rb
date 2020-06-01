# frozen_string_literal: true

class Tournament < ApplicationRecord
  class UpdateForm < Reform::Form
    property :competitors_limit
    property :description
    property :name
    property :result_names,
             populator: lambda { |fragment:, **|
               self.result_names = fragment.reject(&:blank?)
             }
    property :starts_at,
             skip_if: ->(*) { !model.created? }

    validation do
      option :form

      params do
        required(:competitors_limit).filled(:int?, gt?: 1)
        required(:name).filled(:str?)
        required(:result_names).filled(:array?).each(:str?)
        optional(:starts_at).filled(:date_time?)
      end

      rule(:starts_at) do
        if form.model.status.created?
          key.failure(I18n.t('errors.messages.future_date')) unless value > Time.current
        end
      end
    end
  end
end
