class MigrateAuthyToTwilioVerify < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :authy_sms, :twilio_verify_sms
    rename_column :users, :authy_enabled, :twilio_verify_enabled
    rename_column :users, :last_sign_in_with_authy, :last_sign_in_with_twilio_verify

    add_column :users, :twilio_totp_factor_sid, :string
  end
end
