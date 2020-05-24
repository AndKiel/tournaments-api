# frozen_string_literal: true

class AddDefaultToPlayerResultValues < ActiveRecord::Migration[6.0]
  def change
    change_column_default :players, :result_values, from: nil, to: []
  end
end
