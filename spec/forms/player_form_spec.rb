# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayerForm do
  subject(:form) { described_class.new(player) }

  let(:tournament) { create(:tournament, result_names_count: 2) }
  let(:round) { create(:round, tournament: tournament) }
  let(:player) { build(:player, round: round) }

  it 'validates presence of result values' do
    result = form.validate(result_values: nil)
    expect(result).to be false
    expect(form.errors[:result_values]).to include 'must be filled'
  end

  it 'validates length of result values' do
    result = form.validate(result_values: [1])
    expect(result).to be false
    expect(form.errors[:result_values]).to include I18n.t('errors.attributes.result_values.invalid')
  end

  it 'validates result values being integer' do
    result = form.validate(result_values: ['A'])
    expect(result).to be false
    expect(form.errors[:result_values]).to eq(0 => [I18n.t('errors.messages.not_an_integer')])
  end

  it 'returns true for valid attributes' do
    result = form.validate(result_values: [1, 73])
    expect(result).to be true
  end
end
