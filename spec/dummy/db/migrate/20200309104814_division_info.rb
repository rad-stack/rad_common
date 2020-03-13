class DivisionInfo < ActiveRecord::Migration[6.0]
  def change
    add_column :divisions, :additional_info, :string
  end
end
