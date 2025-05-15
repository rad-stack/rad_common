class TwoFactorAuthUpdates < ActiveRecord::Migration[7.2]
  def change
    add_column :security_roles, :two_factor_auth, :boolean, null: false, default: true
    return if SecurityRole.none?

    SecurityRole.where(admin: true).update_all two_factor_auth: true
    SecurityRole.all.update_all two_factor_auth: true if RadConfig.twilio_enabled? && RadConfig.twilio_verify_all_users?
  end
end
