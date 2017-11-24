class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players, id: :uuid do |t|
      t.references :competitor, type: :uuid, null: false, foreign_key: true
      t.references :round, type: :uuid, null: false, foreign_key: true
      t.integer :table_number, null: false
      t.integer :result_values, null: false, array: true

      t.timestamps
    end
  end
end
