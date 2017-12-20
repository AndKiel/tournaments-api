class RemoveNumberFromRounds < ActiveRecord::Migration[5.1]
  def up
    remove_column :rounds, :number, :integer
  end
end
