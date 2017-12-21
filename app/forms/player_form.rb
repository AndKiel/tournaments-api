class PlayerForm < Reform::Form
  property :result_values,
           populator: lambda { |fragment:, **|
             self.result_values = fragment.reject(&:blank?)
           }

  validation :default do
    validates :result_values,
              presence: true
  end

  validation :additional, if: :default do
    validate :length_of_result_values
  end

  def length_of_result_values
    count = model.tournament.result_names.length
    errors.add(:result_values, :wrong_length, count: count) unless result_values.length == count
  end
end
