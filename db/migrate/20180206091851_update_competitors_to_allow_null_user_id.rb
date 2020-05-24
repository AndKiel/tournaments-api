# frozen_string_literal: true

class UpdateCompetitorsToAllowNullUserId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :competitors, :user_id, true
  end
end
