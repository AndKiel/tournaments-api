# frozen_string_literal: true

# == Schema Information
#
# Table name: tournaments
#
#  id                :uuid             not null, primary key
#  competitors_limit :integer          not null
#  description       :text             default(""), not null
#  name              :string           not null
#  result_names      :string           not null, is an Array
#  starts_at         :datetime
#  status            :integer          default("created"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  organiser_id      :uuid             not null
#
# Indexes
#
#  index_tournaments_on_organiser_id  (organiser_id)
#
# Foreign Keys
#
#  fk_rails_...  (organiser_id => users.id)
#
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
