require 'rails_helper'

RSpec.describe TournamentForm do
  subject { described_class.new(Tournament.new) }

  it 'validates presence of competitors limit' do
    result = subject.validate(competitors_limit: nil)
    expect(result).to be false
    expect(subject.errors[:competitors_limit]).to include I18n.t('errors.messages.blank')
  end

  it 'validates numericality of competitors limit' do
    result = subject.validate(competitors_limit: 2.5)
    expect(result).to be false
    expect(subject.errors[:competitors_limit]).to include I18n.t('errors.messages.not_an_integer')

    result = subject.validate(competitors_limit: -20)
    expect(result).to be false
    expect(subject.errors[:competitors_limit]).to include I18n.t('errors.messages.greater_than', count: 1)
  end

  it 'validates presence of name' do
    result = subject.validate(name: '')
    expect(result).to be false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.blank')
  end

  it 'validates presence of result names' do
    result = subject.validate(result_names: nil)
    expect(result).to be false
    expect(subject.errors[:result_names]).to include I18n.t('errors.messages.blank')
  end

  it 'validates length of result names' do
    result = subject.validate(result_names: [])
    expect(result).to be false
    expect(subject.errors[:result_names]).to include I18n.t('errors.messages.too_short', count: 1)
  end

  it 'validates presence of starts at' do
    result = subject.validate(starts_at: nil)
    expect(result).to be false
    expect(subject.errors[:starts_at]).to include I18n.t('errors.messages.blank')
  end

  it 'validates timeliness of starts at' do
    result = subject.validate(starts_at: 'not.a.date')
    expect(result).to be false
    expect(subject.errors[:starts_at]).to include I18n.t('errors.messages.invalid_datetime')

    result = subject.validate(starts_at: 1.day.ago)
    expect(result).to be false
    expect(subject.errors[:starts_at]).to include I18n.t('errors.messages.future_date')
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      competitors_limit: 8,
      name: 'Tenkaichi Budokai',
      result_names: ['Win'],
      starts_at: 7.days.since
    )
    expect(result).to be true
  end
end
