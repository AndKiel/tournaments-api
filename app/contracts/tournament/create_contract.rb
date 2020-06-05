# frozen_string_literal: true

class Tournament < ApplicationRecord
  class CreateContract < ApplicationContract
    json do
      required(:competitors_limit).value(:int?, gt?: 1)
      optional(:description).value(:str?)
      required(:name).value(:str?, :filled?)
      required(:result_names).value(:array?, :filled?).each(:str?, :filled?)
      required(:starts_at).value(:date_time)
    end

    rule(:starts_at) do
      key.failure(:after_now?) if value <= Time.current
    end
  end
end
