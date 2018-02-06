class CompetitorForm < Reform::Form
  property :name
  property :tournament_id, writeable: false

  validates :name,
            presence: true,
            unique: { scope: [:tournament_id] }
end
