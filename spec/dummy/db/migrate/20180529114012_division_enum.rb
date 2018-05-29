class DivisionEnum < ActiveRecord::Migration[5.0]
  def change
    add_column :divisions, :division_status, :integer
  end
end
