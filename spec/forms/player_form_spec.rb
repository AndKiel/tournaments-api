require 'rails_helper'

RSpec.describe PlayerForm do
  subject { described_class.new(players(:discworld_two1)) }

  it 'validates presence of result values' do
    result = subject.validate(result_values: nil)
    expect(result).to be false
    expect(subject.errors[:result_values]).to include I18n.t('errors.messages.blank')
  end

  it 'validates length of result values' do
    result = subject.validate(result_values: [1])
    expect(result).to be false
    expect(subject.errors[:result_values]).to include I18n.t('errors.attributes.result_values.invalid')
  end

  it 'ignores non-integer result values' do
    result = subject.validate(result_values: ['A', nil, 2.2])
    expect(result).to be false
    expect(subject.errors[:result_values]).to include I18n.t('errors.messages.blank')
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      result_values: [1, 73]
    )
    expect(result).to be true
  end
end
