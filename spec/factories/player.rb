# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    table_number { 1 }

    trait :winner do
      result_values { [1] }
    end

    trait :loser do
      result_values { [0] }
    end
  end
end
