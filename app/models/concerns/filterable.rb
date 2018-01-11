module Filterable
  extend ActiveSupport::Concern

  included do
    @__allowed_filters ||= []
  end

  class_methods do
    def filter(name, block)
      symbolized_name = name.to_sym
      @__allowed_filters << symbolized_name
      scope symbolized_name, block
    end

    def apply_filters(params)
      filters = params.fetch(:filters, {}).permit(@__allowed_filters).to_h
      filters.inject(all) do |result, (key, value)|
        if @__allowed_filters.include?(key.to_sym)
          result.public_send(key, value)
        else
          result
        end
      end
    end
  end
end
