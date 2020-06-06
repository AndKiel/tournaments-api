# frozen_string_literal: true

class RoundContract < ApplicationContract
  json do
    required(:competitors_limit).value(:int?, gt?: 1)
    required(:tables_count).value(:int?, gt?: 0)
  end
end
