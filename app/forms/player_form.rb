class PlayerForm < Reform::Form
  property :result_values,
           populator: lambda { |fragment:, **|
             self.result_values = fragment.reject(&:blank?)
           }

  validates :result_values,
            presence: true,
            length: {
              minimum: 1
            }
end
