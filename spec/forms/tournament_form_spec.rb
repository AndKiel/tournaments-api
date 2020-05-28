# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TournamentForm do
  let(:tournament) { build(:tournament) }

  subject(:form) { described_class.new(tournament) }

  it 'validates presence of competitors limit' do
    result = form.validate(competitors_limit: nil)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include I18n.t('errors.messages.blank')
  end

  it 'validates numericality of competitors limit' do
    result = form.validate(competitors_limit: 2.5)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include I18n.t('errors.messages.not_an_integer')

    result = form.validate(competitors_limit: -20)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include I18n.t('errors.messages.greater_than', count: 1)
  end

  it 'validates presence of name' do
    result = form.validate(name: '')
    expect(result).to be false
    expect(form.errors[:name]).to include I18n.t('errors.messages.blank')
  end

  it 'validates presence of result names' do
    result = form.validate(result_names: nil)
    expect(result).to be false
    expect(form.errors[:result_names]).to include I18n.t('errors.messages.blank')
  end

  it 'validates length of result names' do
    result = form.validate(result_names: [])
    expect(result).to be false
    expect(form.errors[:result_names]).to include I18n.t('errors.messages.too_short', count: 1)
  end

  it 'validates presence of starts at' do
    result = form.validate(starts_at: nil)
    expect(result).to be false
    expect(form.errors[:starts_at]).to include I18n.t('errors.messages.blank')
  end

  it 'validates timeliness of starts at' do
    result = form.validate(starts_at: 'not.a.date')
    expect(result).to be false
    expect(form.errors[:starts_at]).to include I18n.t('errors.messages.invalid_datetime')

    result = form.validate(starts_at: 1.day.ago)
    expect(result).to be false
    expect(form.errors[:starts_at]).to include I18n.t('errors.messages.future_date')
  end

  it 'returns true for valid attributes' do
    result = form.validate(
      competitors_limit: 8,
      name: 'Tenkaichi Budokai',
      result_names: ['Win'],
      starts_at: 7.days.since
    )
    expect(result).to be true
  end
end
