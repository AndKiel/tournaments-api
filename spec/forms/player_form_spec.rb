# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerForm do
  let(:tournament) { create(:tournament, result_names_count: 2) }
  let(:round) { create(:round, tournament: tournament) }
  let(:player) { build(:player, round: round) }

  subject(:form) { described_class.new(player) }

  it 'validates presence of result values' do
    result = form.validate(result_values: nil)
    expect(result).to be false
    expect(form.errors[:result_values]).to include I18n.t('errors.messages.blank')
  end

  it 'validates length of result values' do
    result = form.validate(result_values: [1])
    expect(result).to be false
    expect(form.errors[:result_values]).to include I18n.t('errors.attributes.result_values.invalid')
  end

  it 'ignores non-integer result values' do
    result = form.validate(result_values: ['A', nil, 2.2])
    expect(result).to be false
    expect(form.errors[:result_values]).to include I18n.t('errors.messages.blank')
  end

  it 'returns true for valid attributes' do
    result = form.validate(result_values: [1, 73])
    expect(result).to be true
  end
end
