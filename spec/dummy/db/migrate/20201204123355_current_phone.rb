class CurrentPhone < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :current_phone, :integer, default: 0
  end
end
