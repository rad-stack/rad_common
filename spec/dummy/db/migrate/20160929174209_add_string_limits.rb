class AddStringLimits < ActiveRecord::Migration
  def change
    change_table :companies do |t|
      t.change   "name", :string, limit: 255, null: false
      t.change   "phone_number", :string, limit: 255, null: false
      t.change   "website", :string, limit: 255, null: false
      t.change   "email", :string, limit: 255, null: false
      t.change   "address_1", :string, limit: 255, null: false
      t.change   "address_2",  :string, limit: 255
      t.change   "city", :string, limit: 255, null: false
      t.change   "state", :string, limit: 255, null: false
      t.change   "zipcode", :string, limit: 255, null: false
    end

    change_table :users do |t|
      t.change   "email", :string, limit: 255, default: "", null: false
      t.change   "encrypted_password", :string, limit: 255, default: "", null: false
      t.change   "reset_password_token", :string, limit: 255
      t.change   "current_sign_in_ip", :string, limit: 255
      t.change   "last_sign_in_ip", :string, limit: 255
      t.change   "confirmation_token", :string, limit: 255
      t.change   "unconfirmed_email", :string, limit: 255
      t.change   "first_name", :string, limit: 255
      t.change   "last_name", :string, limit: 255
      t.change   "username", :string, limit: 255
      t.change   "mobile_phone", :string, limit: 255
      t.change   "facebook_id", :string, limit: 255, references: nil
      t.change   "timezone", :string, limit: 255
      t.change   "provider_avatar", :string, limit: 255
      t.change   "avatar_file_name", :string, limit: 255
      t.change   "avatar_content_type", :string, limit: 255
      t.change   "global_search_default", :string, limit: 255
    end
  end
end
