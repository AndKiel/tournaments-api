require 'rails_helper'

RSpec.describe User::UpdateForm do
  subject { described_class.new(User.new) }

  it 'validates presence of email' do
    result = subject.validate(email: '')
    expect(result).to be false
    expect(subject.errors[:email]).to include I18n.t('errors.messages.blank')
  end

  it 'validates format of email' do
    result = subject.validate(email: 'not.an.email')
    expect(result).to be false
    expect(subject.errors[:email]).to include I18n.t('activemodel.errors.messages.invalid_email_address')
  end

  it 'validates uniqueness of email' do
    result = subject.validate(email: users(:john).email)
    expect(result).to be false
    expect(subject.errors[:email]).to include I18n.t('errors.messages.taken')
  end

  it 'validates confirmation of password' do
    result = subject.validate(
      email: 'some@one.co',
      password: 'verySecure',
      password_confirmation: 'orNot'
    )
    expect(result).to be false
    expect(subject.errors[:password_confirmation]).to include I18n.t('errors.messages.password_mismatch')
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      email: 'some@one.co',
      password: 'verySecure',
      password_confirmation: 'verySecure'
    )
    expect(result).to be true
  end
end
