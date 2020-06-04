# frozen_string_literal: true

class Tournament < ApplicationRecord
  class UpdateContract < ApplicationContract
    option :model

    json do
      required(:competitors_limit).filled(:int?, gt?: 1)
      required(:name).filled(:str?)
      required(:result_names).array(:str?)
      optional(:starts_at).value(:date_time)
    end

    rule(:starts_at) do
      if model.created?
        key.failure(I18n.t('errors.messages.future_date')) unless value > Time.current
      end
    end
  end
end
