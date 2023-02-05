class MoreSchemaIssues < ActiveRecord::Migration[6.1]
  def change
    change_column :divisions, :id, :bigint, null: false
    change_column :divisions, :owner_id, :bigint, null: false
  end
end
