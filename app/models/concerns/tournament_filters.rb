module TournamentFilters
  extend ActiveSupport::Concern

  included do
    include Filterable

    filter :starts_at_after, ->(date) { where('starts_at > ?', date) }
  end
end
