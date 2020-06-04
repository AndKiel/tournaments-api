# frozen_string_literal: true

class PlayerContract < ApplicationContract
  option :model

  json do
    required(:result_values).array(:int?)
  end

  rule(:result_values) do
    result_names_count = model.tournament.result_names.length
    key.failure(I18n.t('errors.attributes.result_values.invalid')) if value.length != result_names_count
  end
end
