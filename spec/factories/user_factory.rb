# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user, aliases: %i[organiser resource_owner] do
    sequence(:email) { |n| "user.#{n}@mail.co" }
    # password
    password_digest { '$2a$10$DduaGQK4NkMwtaa..reSv.7IruCI35cKIBodTuOPDDb/yPstoqmH2' }
  end
end
