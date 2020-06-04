# frozen_string_literal: true

class PlayerForm < Reform::Form
  property :result_values

  validation do
    option :form

    params do
      required(:result_values).filled(:array?).each(:int?)
    end

    rule(:result_values) do
      result_names_count = form.model.tournament.result_names.length
      key.failure(I18n.t('errors.attributes.result_values.invalid')) if value.length != result_names_count
    end
  end
end
