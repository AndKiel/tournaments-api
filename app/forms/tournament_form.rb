class TournamentForm < Reform::Form
  property :competitors_limit
  property :description
  property :name
  property :result_names
  property :starts_at

  validates :competitors_limit,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 1
            }
  validates :name,
            presence: true

  validates :result_names,
            length: {
              minimum: 1
            }

  validates :starts_at,
            presence: true,
            timeliness: {
              after: :now,
              type: :datetime
            }
end
