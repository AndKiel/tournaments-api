# frozen_string_literal: true

class Tournament < ApplicationRecord
  class CreateForm < Reform::Form
    property :competitors_limit
    property :description
    property :name
    property :result_names,
             populator: lambda { |fragment:, **|
               self.result_names = fragment.reject(&:blank?)
             }
    property :starts_at

    validation do
      params do
        required(:competitors_limit).filled(:int?, gt?: 1)
        required(:name).filled(:str?)
        required(:result_names).filled(:array?).each(:str?)
        required(:starts_at).value(:date_time)
      end

      rule(:starts_at) do
        key.failure(I18n.t('errors.messages.future_date')) unless value > Time.current
      end
    end
  end
end
