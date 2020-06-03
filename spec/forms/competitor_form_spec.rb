# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompetitorForm, :focus do
  subject(:form) { described_class.new(competitor) }

  let(:tournament) { create(:tournament) }
  let(:competitor) { build(:competitor, tournament: tournament) }
  let(:another_competitor) { create(:competitor, tournament: tournament) }
  let(:different_tournament_competitor) { create(:competitor) }

  it 'validates presence of name' do
    result = form.validate(name: nil)
    expect(result).to be false
    expect(form.errors[:name]).to include I18n.t('errors.messages.blank')
  end

  it 'validates uniqueness of name in scope of tournament_id' do
    puts "uniqueness competitor >> tournament_id: #{competitor.tournament_id}"
    puts "uniqueness another competitor >> name: $#{another_competitor.name} | tournament_id #{another_competitor.tournament_id}"
    result = form.validate(name: another_competitor.name)
    expect(result).to be false
    expect(form.errors[:name]).to include I18n.t('errors.messages.taken')
  end

  it 'returns true for valid attributes' do
    puts "valid attributes competitor >> tournament_id: #{competitor.tournament_id}"
    result = form.validate(name: different_tournament_competitor.name)
    expect(result).to be true
  end
end
