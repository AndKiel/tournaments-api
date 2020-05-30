# frozen_string_literal: true

class PlayerForm < Reform::Form
  property :result_values,
           populator: lambda { |fragment:, **|
             self.result_values = fragment.select { |value| value.to_i.to_s == value.to_s }
           }

  validation do
    option :form

    params do
      required(:result_values).filled(:array?)
    end

    rule(:result_values) do
      result_names_count = form.model.round.tournament.result_names.length
      key.failure(I18n.t('errors.attributes.result_values.invalid')) if value.length != result_names_count
    end
  end
end
