# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::UpdateContract do
  subject(:contract) { described_class.new }

  it 'validates competitors_limit being an integer' do
    result = contract.call({ competitors_limit: 2.5 })
    expect(result.errors[:competitors_limit]).to include I18n.t('dry_validation.errors.int?')
  end

  it 'validates competitors_limit being greater than 1' do
    result = contract.call({ competitors_limit: 0 })
    expect(result.errors[:competitors_limit]).to include I18n.t('dry_validation.errors.gt?', num: 1)
  end

  %i[description name].each do |key|
    it "validates #{key} being a string" do
      result = contract.call({ key => 1 })
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.str?')
    end
  end

  it 'validates name being filled' do
    result = contract.call({ name: '' })
    expect(result.errors[:name]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates result_names being an array' do
    result = contract.call({ result_names: '[]' })
    expect(result.errors[:result_names]).to include I18n.t('dry_validation.errors.array?')
  end

  it 'validates result_names being filled' do
    result = contract.call({ result_names: [] })
    expect(result.errors[:result_names]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates result_names members being string' do
    result = contract.call({ result_names: [1] })
    expect(result.errors[:result_names][0]).to include I18n.t('dry_validation.errors.str?')
  end

  it 'validates result_names members being filled' do
    result = contract.call({ result_names: [''] })
    expect(result.errors[:result_names][0]).to include I18n.t('dry_validation.errors.filled?')
  end

  it 'validates starts_at being a date time' do
    result = contract.call({ starts_at: 'not.a.date' })
    expect(result.errors[:starts_at]).to include I18n.t('dry_validation.errors.date_time?')
  end

  it 'validates starts_at being a future date' do
    result = contract.call({ starts_at: 1.day.ago.iso8601 })
    expect(result.errors[:starts_at]).to include I18n.t('dry_validation.errors.after_now?')
  end

  it 'is successful for valid attributes' do
    result = contract.call({
                             competitors_limit: 8,
                             name: 'Tenkaichi Budokai',
                             result_names: ['Win']
                           })
    expect(result.success?).to be true
  end
end
