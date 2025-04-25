class FixSomeRenamedAuditModels < ActiveRecord::Migration[7.0]
  def change
    return unless RadAudit.exists?

    rename_audits 'SecurityGroup', 'SecurityRole'
    rename_audits 'SecurityRolesUser', 'UserSecurityRole'
  end

  private

    def rename_audits(old_name, new_name)
      RadAudit.where(auditable_type: old_name).update_all auditable_type: new_name
      RadAudit.where(associated_type: old_name).update_all associated_type: new_name
    end
end
