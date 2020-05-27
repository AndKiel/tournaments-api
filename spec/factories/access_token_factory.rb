# frozen_string_literal: true

FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    expires_in { 2.hours }
    scopes { 'public' }
  end
end
