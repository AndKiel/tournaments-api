# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::UpdateForm do
  subject(:form) { described_class.new(user) }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  it 'validates presence of email' do
    result = form.validate(email: '')
    expect(result).to be false
    expect(form.errors[:email]).to include I18n.t('errors.messages.blank')
  end

  it 'validates format of email' do
    result = form.validate(email: 'not.an.email')
    expect(result).to be false
    expect(form.errors[:email]).to include I18n.t('activemodel.errors.messages.invalid_email_address')
  end

  it 'validates uniqueness of email' do
    result = form.validate(email: another_user.email)
    expect(result).to be false
    expect(form.errors[:email]).to include I18n.t('errors.messages.taken')
  end

  it 'allows to skip password' do
    result = form.validate(email: 'some@one.co')
    expect(result).to be true
  end

  it 'validates confirmation of password' do
    result = form.validate(
      password: 'verySecure',
      password_confirmation: 'orNot'
    )
    expect(result).to be false
    expect(form.errors[:password_confirmation]).to include I18n.t('errors.messages.password_mismatch')
  end

  it 'returns true for valid attributes' do
    result = form.validate(
      email: 'some@one.co',
      password: 'verySecure',
      password_confirmation: 'verySecure'
    )
    expect(result).to be true
  end
end
