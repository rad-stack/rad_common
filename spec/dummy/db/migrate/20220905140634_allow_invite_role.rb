class AllowInviteRole < ActiveRecord::Migration[6.1]
  def change
    add_column :security_roles, :allow_invite, :boolean, null: false, default: false
    # return if User.none?
    #
    # # TODO: modify this as needed to fix production users and roles
    # SecurityRole.find_by!(name: 'Admin').update! allow_invite: true
    #
    # user_role = SecurityRole.create! name: 'User', allow_invite: true
    # User.internal.each do |user|
    #   next if user.admin?
    #
    #   UserSecurityRole.create! user: user, security_role: user_role
    # end
    #
    # client_role = SecurityRole.create! name: 'Client User', allow_invite: true, external: true
    #
    # User.external.each do |user|
    #   UserSecurityRole.create! user: user, security_role: client_role
    # end
  end
end
