class MoreDivisionFields < ActiveRecord::Migration[5.2]
  def change
    add_column :divisions, :notify, :boolean, null: false, default: false
    add_column :divisions, :timezone, :string
  end
end
