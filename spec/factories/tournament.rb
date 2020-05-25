# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    competitors_limit { 12 }
    name { 'Game Tournament' }
    result_names { ['Win'] }
    starts_at { 1.day.since }
    status { 'created' }

    trait :in_progress do
      starts_at { 1.minute.ago }
      status { 'in_progress' }
    end

    trait :ended do
      starts_at { 1.day.ago }
      status { 'ended' }
    end
  end
end
