# frozen_string_literal: true

class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_view :results
  end
end
