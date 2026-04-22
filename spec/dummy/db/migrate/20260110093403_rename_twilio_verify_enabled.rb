class RenameTwilioVerifyEnabled < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :twilio_verify_enabled, :otp_required_for_login
  end
end
