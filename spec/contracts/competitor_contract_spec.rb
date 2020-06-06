# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompetitorContract do
  subject(:contract) { described_class.new(model: competitor) }

  let(:tournament) { create(:tournament) }
  let(:competitor) { build(:competitor, tournament: tournament) }
  let(:another_competitor) { create(:competitor, tournament: tournament) }
  let(:different_tournament_competitor) { create(:competitor) }

  it 'validates name key presence' do
    result = contract.call({})
    expect(result.errors[:name]).to include I18n.t('dry_validation.errors.key?')
  end

  it 'validates name being a string' do
    result = contract.call({ name: 1 })
    expect(result.errors[:name]).to include I18n.t('dry_validation.errors.str?')
  end

  it 'validates name being filled' do
    result = contract.call({ name: '' })
    expect(result.errors[:name]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates name being unique in the scope of a tournament_id' do
    result = contract.call(name: another_competitor.name)
    expect(result.errors[:name]).to include I18n.t('dry_validation.errors.unique?')
  end

  it 'is successful for valid attributes' do
    result = contract.call(name: different_tournament_competitor.name)
    expect(result.success?).to be true
  end
end
