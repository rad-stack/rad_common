class AddRadbearUserFields < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :facebook_id, :string, references: nil
    add_column :users, :facebook_access_token, :string
    add_column :users, :facebook_expires_at, :datetime
    add_column :users, :twitter_id, :string, references: nil
    add_column :users, :twitter_access_token, :string
    add_column :users, :twitter_access_secret, :string
    add_column :users, :timezone, :string
    add_column :users, :provider_avatar, :string

    # add_attachment :users, :avatar

    add_index :users, :username, unique: true
  end
end
