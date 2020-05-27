# frozen_string_literal: true

FactoryBot.define do
  factory :competitor do
    sequence(:name) { |n| "Competitor #{n}" }
    status { 'enlisted' }

    association :tournament
    association :user

    trait :anonymous do
      user { nil }
    end

    trait :confirmed do
      status { 'confirmed' }
    end
  end
end
