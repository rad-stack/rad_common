class AuthyNoSMS < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :authy_sms, :boolean, null: false, default: true
  end
end
