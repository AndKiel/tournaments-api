# frozen_string_literal: true

RSpec.describe RoundContract do
  subject(:contract) { described_class.new(model: round) }

  let(:round) { build(:round) }

  %i[competitors_limit tables_count].each do |key|
    it "validates #{key} key presence" do
      result = contract.call({})
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.key?')
    end

    it "validates #{key} being an integer" do
      result = contract.call({ key => '' })
      expect(result.errors[key]).to include I18n.t('dry_validation.errors.int?')
    end
  end

  it 'validates competitors_limit being greater than 1' do
    result = contract.call({ competitors_limit: -20 })
    expect(result.errors[:competitors_limit]).to include I18n.t('dry_validation.errors.gt?', num: 1)
  end

  it 'validates tables_count being greater than 0' do
    result = contract.call({ tables_count: -20 })
    expect(result.errors[:tables_count]).to include I18n.t('dry_validation.errors.gt?', num: 0)
  end

  it 'is successful for valid attributes' do
    result = contract.call({
                             competitors_limit: 8,
                             tables_count: 4
                           })
    expect(result.success?).to be true
  end
end
