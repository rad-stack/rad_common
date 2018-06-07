class ExpandFacebookAccessToken < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :facebook_access_token, :text
  end
end
