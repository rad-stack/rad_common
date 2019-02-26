class DeviseInvitableAddToUsers < ActiveRecord::Migration[5.2]
  def up
    change_table :users do |t|
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.integer    :invited_by_id
      t.integer    :invitations_count, default: 0

      t.index      :invitations_count
      t.index      :invitation_token, unique: true # for invitable
      t.index      :invited_by_id
    end

    add_foreign_key 'users', 'users', column: 'invited_by_id'

    add_column :users, :external, :boolean, null: false, default: false
  end
end
