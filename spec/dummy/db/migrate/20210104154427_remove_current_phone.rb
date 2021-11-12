class RemoveCurrentPhone < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :current_phone
  end
end
