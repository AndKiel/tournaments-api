class CreateCompetitors < ActiveRecord::Migration[5.1]
  def change
    create_table :competitors, id: :uuid do |t|
      t.references :tournament, type: :uuid, null: false, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
