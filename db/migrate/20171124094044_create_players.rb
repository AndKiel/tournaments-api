# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players, id: :uuid do |t|
      t.references :competitor, type: :uuid, null: false, foreign_key: true
      t.references :round, type: :uuid, null: false, foreign_key: true
      t.integer :table_number, null: false
      t.integer :result_values, null: false, array: true, default: []

      t.timestamps
    end
  end
end
