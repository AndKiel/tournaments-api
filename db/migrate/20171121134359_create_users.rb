# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true

    add_foreign_key :oauth_access_grants, User, column: :resource_owner_id
    add_foreign_key :oauth_access_tokens, User, column: :resource_owner_id
  end
end
