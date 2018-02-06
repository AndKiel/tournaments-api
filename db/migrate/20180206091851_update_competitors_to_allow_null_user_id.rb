class UpdateCompetitorsToAllowNullUserId < ActiveRecord::Migration[5.1]
  def change
    change_column_null :competitors, :user_id, true
  end
end
