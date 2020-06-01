# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoundForm do
  subject(:form) { described_class.new(round) }

  let(:round) { build(:round) }

  it 'validates presence of competitors limit' do
    result = form.validate(competitors_limit: nil)
    expect(result).to be false
    expect(form.errors[:competitors_limit]).to include 'must be filled'
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

  it 'validates presence of tables count' do
    result = form.validate(tables_count: nil)
    expect(result).to be false
    expect(form.errors[:tables_count]).to include 'must be filled'
  end

  it 'validates tables count being integer' do
    result = form.validate(tables_count: 2.5)
    expect(result).to be false
    expect(form.errors[:tables_count]).to include I18n.t('errors.messages.not_an_integer')
  end

  it 'validates tables count being greater than 0' do
    result = form.validate(tables_count: -20)
    expect(result).to be false
    expect(form.errors[:tables_count]).to include I18n.t('errors.messages.greater_than', count: 0)
  end

  it 'returns true for valid attributes' do
    result = form.validate(
      competitors_limit: 8,
      tables_count: 4
    )
    expect(result).to be true
  end
end
