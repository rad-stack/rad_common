class AllowInviteRole < ActiveRecord::Migration[6.1]
  def change
    add_column :security_roles, :allow_invite, :boolean, null: false, default: false
  end
end
