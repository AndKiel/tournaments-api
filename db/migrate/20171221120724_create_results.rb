class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_view :results
  end
end
