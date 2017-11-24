class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds, id: :uuid do |t|
      t.references :tournament, type: :uuid, null: false, foreign_key: true
      t.integer :number, null: false
      t.integer :competitors_limit, null: false
      t.integer :tables_count, null: false

      t.timestamps
    end
  end
end
