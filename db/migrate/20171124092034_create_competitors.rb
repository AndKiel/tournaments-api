# frozen_string_literal: true

class CreateCompetitors < ActiveRecord::Migration[6.0]
  def change
    create_table :competitors, id: :uuid do |t|
      t.references :tournament, type: :uuid, null: false, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end
