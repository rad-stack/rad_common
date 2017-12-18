class RemoveTwitter < ActiveRecord::Migration
  def change
    remove_column :users, :twitter_id
    remove_column :users, :twitter_access_token
    remove_column :users, :twitter_access_secret
  end
end
