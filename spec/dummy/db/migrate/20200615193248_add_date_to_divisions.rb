class AddDateToDivisions < ActiveRecord::Migration[6.0]
  def change
    add_column :divisions, :date_established, :date
  end
end
