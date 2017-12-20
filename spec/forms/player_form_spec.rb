require 'rails_helper'

RSpec.describe PlayerForm do
  subject { described_class.new(Player.new) }

  it 'validates length of result values' do
    result = subject.validate(result_values: [])
    expect(result).to be false
    expect(subject.errors[:result_values]).to include I18n.t('errors.messages.too_short', count: 1)
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      result_values: ['Win']
    )
    expect(result).to be true
  end
end
