# TODO: Delete this file later

class TournamentUpdateContract < Dry::Validation::Contract
  option :model

  params do
    optional(:starts_at).value(:date_time)
  end

  rule(:starts_at) do
    if model.created?
      key.failure(I18n.t('errors.messages.future_date')) unless value > Time.current
    end
  end
end

RSpec.describe TournamentUpdateContract, :focus do
  subject(:contract) { described_class.new(model: tournament) }

  let(:tournament) { create(:tournament) }

  it 'validates starts at being datetime' do
    result = subject.call({ starts_at: 'not.a.date' })
    expect(result.errors[:starts_at]).to include 'must be a date time'
  end

  it 'validates starts at being a future date' do
    result = subject.call({ starts_at: 1.day.ago.iso8601 })
    expect(result.errors[:starts_at]).to include I18n.t('errors.messages.future_date')
  end

  it 'returns true for valid attributes' do
    result = subject.call({ starts_at: 7.days.since.iso8601 })
    expect(result.errors).to be_empty
  end

  context 'when tournament does not have created status' do
    let(:tournament) { create(:tournament, :in_progress) }

    it 'skips starts at validation' do
      # result = subject.call({ starts_at: nil }) => FAIL! Errors!
      result = subject.call({})
      expect(result.errors).to be_empty # SUCCESS! Contract ignores lack of key!
    end
  end
end
