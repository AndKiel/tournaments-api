# frozen_string_literal: true

RSpec.describe PlayerContract do
  subject(:contract) { described_class.new(model: player) }

  let(:tournament) { create(:tournament, result_names_count: 2) }
  let(:round) { create(:round, tournament: tournament) }
  let(:player) { build(:player, round: round) }

  it 'validates result_values key presence' do
    result = contract.call({})
    expect(result.errors[:result_values]).to include I18n.t('dry_validation.errors.key?')
  end

  it 'validates result_values being an array' do
    result = contract.call({ result_values: 1 })
    expect(result.errors[:result_values]).to include I18n.t('dry_validation.errors.array?')
  end

  it 'validates result_values being filled' do
    result = contract.call({ result_values: [] })
    expect(result.errors[:result_values]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates result_values members being integer' do
    result = contract.call({ result_values: [''] })
    expect(result.errors[:result_values][0]).to include I18n.t('dry_validation.errors.int?')
  end

  it 'validates result_values size' do
    result = contract.call({ result_values: [1] })
    expect(result.errors[:result_values]).to include I18n.t('dry_validation.errors.rules.result_values.size?')
  end

  it 'is successful for valid attributes' do
    result = contract.call({ result_values: [1, 73] })
    expect(result.success?).to be true
  end
end
