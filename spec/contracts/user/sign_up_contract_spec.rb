# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::SignUpContract do
  subject(:contract) { described_class.new }

  let(:another_user) { create(:user) }

  %i[email password password_confirmation].each do |key|
    it "validates #{key} key presence" do
      result = contract.call({})
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.key?')
    end

    it "validates #{key} being a string" do
      result = contract.call({ key => 1 })
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.str?')
    end

    it "validates #{key} being filled" do
      result = contract.call({ key => '' })
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.filled?')
    end
  end

  it 'validates email format' do
    result = contract.call({ email: 'not.an.email' })
    expect(result.errors[:email]).to include I18n.t('dry_validation.errors.email?')
  end

  it 'validates email being unique' do
    result = contract.call({ email: another_user.email })
    expect(result.errors[:email]).to include I18n.t('dry_validation.errors.unique?')
  end

  it 'validates password being confirmed' do
    result = contract.call({
                             password: 'verySecure',
                             password_confirmation: 'orNot'
                           })
    error_message = I18n.t('dry_validation.errors.confirmed?.arg.default', key: :password)
    expect(result.errors[:password_confirmation]).to include error_message
  end

  it 'is successful for valid attributes' do
    result = contract.call({
                             email: 'some@one.co',
                             password: 'verySecure',
                             password_confirmation: 'verySecure'
                           })
    expect(result.success?).to be true
  end
end
