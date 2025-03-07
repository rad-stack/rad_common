class AddDetectedTimezoneToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :detected_timezone, :string
    add_column :users, :ignored_timezone, :string
  end
end
