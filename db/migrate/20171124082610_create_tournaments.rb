class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments, id: :uuid do |t|
      t.text :name, null: false
      t.text :description, null: false, default: ''
      t.integer :competitors_limit
      t.integer :status
      t.references :organiser, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.datetime :starts_at

      t.timestamps
    end
  end
end
