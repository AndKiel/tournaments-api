module TournamentFilters
  extend ActiveSupport::Concern

  included do
    include Filterable

    filter :starts_at_after, ->(date) { where('starts_at > ?', date) if date.present? }
    filter :with_name, ->(name) { where('name ILIKE ?', "%#{name}%") if name.present? }
  end
end
