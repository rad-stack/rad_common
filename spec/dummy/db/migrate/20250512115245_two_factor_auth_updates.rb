class TwoFactorAuthUpdates < ActiveRecord::Migration[7.2]
  def change
    add_column :security_roles, :two_factor_auth, :boolean, null: false, default: true
    return if SecurityRole.none? || !RadConfig.twilio_enabled? || RadConfig.twilio_verify_all_users?

    SecurityRole.where(admin: false).update_all two_factor_auth: false
  end
end
