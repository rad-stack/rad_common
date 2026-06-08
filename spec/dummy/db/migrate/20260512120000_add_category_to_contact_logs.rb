class AddCategoryToContactLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :contact_logs, :category, :string
  end
end
