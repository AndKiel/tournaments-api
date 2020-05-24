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
      count = form.model.tournament.result_names.length
      key.failure(I18n.t('errors.attributes.result_values.invalid')) unless value.length == count
    end
  end
end
