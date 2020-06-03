# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::UpdateForm, :focus do
  subject(:form) { described_class.new(tournament) }

  let(:tournament) { create(:tournament) }

  it 'validates presence of competitors limit' do
    result = form.validate(competitors_limit: nil)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include I18n.t('errors.messages.blank')
  end

  it 'validates competitors limit being integer' do
    result = form.validate(competitors_limit: 2.5)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include I18n.t('errors.messages.not_an_integer')
  end

  it 'validates competitors limit being greater than 1' do
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
    expect(form.errors[:result_names]).to include I18n.t('errors.messages.blank')
  end

  it 'validates starts at being datetime' do
    result = form.validate(starts_at: 'not.a.date')
    expect(result).to be false
    expect(form.errors[:starts_at]).to include 'must be a date time'
  end

  it 'validates starts at being a future date' do
    result = form.validate(starts_at: 1.day.ago.iso8601)
    expect(result).to be false
    expect(form.errors[:starts_at]).to include I18n.t('errors.messages.future_date')
  end

  it 'returns true for valid attributes' do
    result = form.validate(
      competitors_limit: 8,
      name: 'Tenkaichi Budokai',
      result_names: ['Win'],
      starts_at: 7.days.since.iso8601
    )
    expect(result).to be true
  end

  context 'when tournament does not have created status' do
    let(:tournament) { create(:tournament, :in_progress) }

    it 'skips starts at validation' do
      result = form.validate(starts_at: 'not.a.date')
      expect(result).to be true
    end
  end
end
