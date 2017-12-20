require 'rails_helper'

RSpec.describe RoundForm do
  subject { described_class.new(Round.new(tournament: tournaments(:tenkaichi_budokai))) }

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

  it 'validates presence of tables count' do
    result = subject.validate(tables_count: nil)
    expect(result).to be false
    expect(subject.errors[:tables_count]).to include I18n.t('errors.messages.blank')
  end

  it 'validates numericality of tables count' do
    result = subject.validate(tables_count: 2.5)
    expect(result).to be false
    expect(subject.errors[:tables_count]).to include I18n.t('errors.messages.not_an_integer')

    result = subject.validate(tables_count: -20)
    expect(result).to be false
    expect(subject.errors[:tables_count]).to include I18n.t('errors.messages.greater_than', count: 0)
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      competitors_limit: 8,
      tables_count: 4
    )
    expect(result).to be true
  end
end
