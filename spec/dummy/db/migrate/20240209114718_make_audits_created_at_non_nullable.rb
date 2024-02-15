class MakeAuditsCreatedAtNonNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :audits, :created_at, false
  end
end
