# frozen_string_literal: true

FactoryBot.define do
  factory :round do
    competitors_limit { 12 }
    tables_count { 3 }
  end
end
