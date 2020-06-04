# frozen_string_literal: true

class RoundContract < ApplicationContract
  json do
    required(:competitors_limit).filled(:int?, gt?: 1)
    required(:tables_count).filled(:int?, gt?: 0)
  end
end
