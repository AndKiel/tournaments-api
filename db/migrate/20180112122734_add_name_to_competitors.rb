class AddNameToCompetitors < ActiveRecord::Migration[5.1]
  class FakeCompetitor < ApplicationRecord
    self.table_name = :competitors

    belongs_to :user, foreign_key: :user_id, class_name: 'FakeUser'
  end

  class FakeUser < ApplicationRecord
    self.table_name = :users
  end


  def up
    add_column :competitors, :name, :string

    FakeCompetitor.find_each do |competitor|
      name_from_email = competitor.user.email.split('@')[0]
      competitor.update!(name: name_from_email)
    end

    change_column_null :competitors, :name, false
  end

  def down
    remove_column :competitors, :name
  end
end
