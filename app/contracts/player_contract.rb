# frozen_string_literal: true

class PlayerContract < ApplicationContract
  option :model

  json do
    required(:result_values).value(:array?, :filled?).each(:int?)
  end

  rule(:result_values) do
    result_names_count = model.tournament.result_names.length
    key.failure(I18n.t('dry_validation.errors.rules.result_values.size?')) if value.length != result_names_count
  end
end
