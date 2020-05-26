# frozen_string_literal: true

FactoryBot.define do
  factory :competitor do
    sequence(:name) { |n| "Competitor #{n}" }
    status { 'enlisted' }

    association :tournament
    association :user

    trait :confirmed do
      status { 'confirmed' }
    end
  end
end
