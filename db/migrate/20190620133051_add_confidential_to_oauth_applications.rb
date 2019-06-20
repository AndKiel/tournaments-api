# frozen_string_literal: true

class AddConfidentialToOauthApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :oauth_applications, :confidential, :boolean, null: false, default: true
  end
end
