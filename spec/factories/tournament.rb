# frozen_string_literal: true

FactoryBot.define do
  factory :tournament do
    transient do
      result_names_count { 1 }
    end

    competitors_limit { 12 }
    name { 'Game Tournament' }
    result_names { Array.new(result_names_count) { 'Win' } }
    starts_at { 1.day.since }
    status { 'created' }

    association :organiser

    trait :ended do
      past
      status { 'ended' }
    end

    trait :in_progress do
      past
      status { 'in_progress' }
    end

    trait :past do
      starts_at { 1.minute.ago }
    end
  end
end
