class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments, id: :uuid do |t|
      t.references :organiser, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.text :description, null: false, default: ''
      t.string :result_names, null: false, array: true
      t.datetime :starts_at
      t.integer :competitors_limit, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
