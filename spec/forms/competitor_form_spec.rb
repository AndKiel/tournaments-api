require 'rails_helper'

RSpec.describe CompetitorForm do
  subject do
    competitor = Competitor.new(
      user: users(:andrew),
      tournament: tournaments(:game_of_thrones)
    )
    described_class.new(competitor)
  end

  it 'validates presence of name' do
    result = subject.validate(name: nil)
    expect(result).to be false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.blank')
  end

  it 'validates uniqueness of name in scope of tournament_id' do
    result = subject.validate(name: 'Hellen')
    expect(result).to be false
    expect(subject.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  it 'returns true for valid attributes' do
    result = subject.validate(
      name: 'Andrew'
    )
    expect(result).to be true
  end
end
