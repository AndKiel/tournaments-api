# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:organiser, :resource_owner] do
    sequence(:email) { |n| "user.#{n}@mail.co" }
    # password
    password_digest { '$2a$10$DduaGQK4NkMwtaa..reSv.7IruCI35cKIBodTuOPDDb/yPstoqmH2' }
  end
end
