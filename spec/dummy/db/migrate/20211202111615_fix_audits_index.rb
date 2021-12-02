class FixAuditsIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :audits, name: 'index_audits_on_version'
    remove_index :audits, name: 'auditable_index'

    add_index :audits, %i[auditable_id auditable_type version], name: 'auditable_index'
  end
end
