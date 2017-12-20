class RoundForm < Reform::Form
  property :competitors_limit
  property :tables_count

  validates :competitors_limit,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 1
            }

  validates :tables_count,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0
            }
end
