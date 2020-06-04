# frozen_string_literal: true

class Tournament < ApplicationRecord
  class CreateContract < ApplicationContract
    json do
      required(:competitors_limit).filled(:int?, gt?: 1)
      required(:name).filled(:str?)
      required(:result_names).filled(:array?).each(:str?, :filled?)
      required(:starts_at).value(:date_time)
    end

    rule(:starts_at) do
      key.failure(:after_now?) unless value > Time.current
    end
  end
end
