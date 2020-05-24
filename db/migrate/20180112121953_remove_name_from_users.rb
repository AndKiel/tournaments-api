# frozen_string_literal: true

class RemoveNameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name, :string, null: false, default: ''
  end
end
