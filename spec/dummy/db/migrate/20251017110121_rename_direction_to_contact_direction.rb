class RenameDirectionToContactDirection < ActiveRecord::Migration[7.2]
  def change
    rename_column :contact_logs, :direction, :contact_direction
  end
end
