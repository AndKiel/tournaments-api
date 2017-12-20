class AddDefaultToPlayerResultValues < ActiveRecord::Migration[5.1]
  def change
    change_column_default :players, :result_values, from: nil, to: []
  end
end
