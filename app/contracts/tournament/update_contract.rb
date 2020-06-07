# frozen_string_literal: true

class Tournament < ApplicationRecord
  class UpdateContract < ApplicationContract
    option :model

    json do
      optional(:competitors_limit).value(:int?, gt?: 1)
      optional(:description).value(:str?)
      optional(:name).value(:str?, :filled?)
      optional(:result_names).value(:array?, :filled?).each(:str?, :filled?)
      optional(:starts_at).value(:date_time)
    end

    rule(:starts_at) do
      key.failure(:after_now?) if key? && value != model.starts_at && value <= Time.current
    end
  end
end
