class AddDetectedTimezoneToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :detected_timezone, :string
  end
end
