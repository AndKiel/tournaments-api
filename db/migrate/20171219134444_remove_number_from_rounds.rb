# frozen_string_literal: true

class RemoveNumberFromRounds < ActiveRecord::Migration[6.0]
  def up
    remove_column :rounds, :number, :integer
  end
end
