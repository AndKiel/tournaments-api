# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::UpdateContract do
  subject(:contract) { described_class.new(model: user) }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  %i[email password password_confirmation].each do |key|
    it "validates #{key} being a string" do
      result = contract.call({ key => 1 })
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.str?')
    end
  end

  it "validates email being filled" do
    result = contract.call({ email: '' })
    expect(result.errors[:email]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates format of email' do
    result = contract.call({ email: 'not.an.email' })
    expect(result.errors[:email]).to include I18n.t('dry_validation.errors.email?')
  end

  it 'validates uniqueness of email' do
    result = contract.call({ email: another_user.email })
    expect(result.errors[:email]).to include I18n.t('dry_validation.errors.unique?')
  end

  it 'validates confirmation of password' do
    result = contract.call({
                             password: 'verySecure',
                             password_confirmation: 'orNot'
                           })
    expect(result.errors[:password_confirmation]).to include I18n.t('dry_validation.errors.confirmed?.arg.default', key: :password)
  end

  it 'returns true for valid attributes' do
    result = contract.call({
                             email: user.email
                           })
    expect(result.success?).to be true
  end
end
