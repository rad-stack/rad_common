class UserJsTimezone < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :detected_timezone_js, :string
  end
end
