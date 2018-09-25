class RemoveRadCommonUnusedFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :username
    remove_column :users, :facebook_id
    remove_column :users, :facebook_access_token
    remove_column :users, :facebook_expires_at
    remove_column :users, :provider_avatar
  end
end
