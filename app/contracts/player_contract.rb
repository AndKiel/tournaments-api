# frozen_string_literal: true

class PlayerContract < ApplicationContract
  option :model

  json do
    required(:result_values).value(:array?, :filled?).each(:int?)
  end

  rule(:result_values) do
    if value.length != model.tournament.result_names.length
      key.failure(I18n.t('dry_validation.errors.rules.result_values.size?'))
    end
  end
end
