class AddTwilioTotpFactorSidToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :twilio_totp_factor_sid, :string unless column_exists?(:users, :twilio_totp_factor_sid)
    add_column :users, :last_sign_in_with_twilio_verify, :datetime unless column_exists?(:users, :last_sign_in_with_twilio_verify)
  end
end
