# frozen_string_literal: true

class RoundForm < Reform::Form
  property :competitors_limit
  property :tables_count

  validation do
    params do
      required(:competitors_limit).filled(:int?, gt?: 1)
      required(:tables_count).filled(:int?, gt?: 0)
    end
  end
end
