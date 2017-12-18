class ExpandFacebookAccessToken < ActiveRecord::Migration
  def change
    change_column :users, :facebook_access_token, :text
  end
end