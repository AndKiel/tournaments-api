# frozen_string_literal: true

FactoryBot.define do
  factory :competitor do
    sequence(:name) { |n| "Competitor #{n}" }
    status { 'enlisted' }
  end
end
