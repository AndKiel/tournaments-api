class PlayerForm < Reform::Form
  property :result_values

  validates :result_values,
            length: {
              minimum: 1
            }
end
