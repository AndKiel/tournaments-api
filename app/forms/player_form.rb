# frozen_string_literal: true

class PlayerForm < Reform::Form
  property :result_values,
           populator: lambda { |fragment:, **|
             self.result_values = fragment.select { |value| value.to_i.to_s == value.to_s }
           }

  validation do
    params do
      required(:result_values).filled(:array?)
    end

    # FIXME: How to use form/model from dry?
    # rule(:result_values) do
    #   count = form.model.tournament.result_names.length
    #   key.failure(:invalid) unless result_values.length == count
    # end
  end
end
