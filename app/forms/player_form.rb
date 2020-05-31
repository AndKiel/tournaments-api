# frozen_string_literal: true

class PlayerForm < Reform::Form
  property :result_values,
           populator: lambda { |fragment:, **|
             self.result_values = fragment.select { |value| value.to_i.to_s == value.to_s }
           }

  validation(name: :default) do
    validates :result_values,
              presence: true
  end

  validation(name: :additional, if: :default) do
    validate :length_of_result_values
  end

  def length_of_result_values
    result_names_length = model.tournament.result_names.length
    errors.add(:result_values, :invalid) unless result_values.length == result_names_length
  end
end
