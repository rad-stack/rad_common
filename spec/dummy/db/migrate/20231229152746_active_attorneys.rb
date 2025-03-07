class ActiveAttorneys < ActiveRecord::Migration[7.0]
  def change
    add_column :attorneys, :active, :boolean, null: false, default: true
  end
end
