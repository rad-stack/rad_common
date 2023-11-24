class MoreTwilioVerify < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :twilio_verify_sms
    remove_column :users, :authy_id
    remove_column :users, :twilio_totp_factor_sid
  end
end
