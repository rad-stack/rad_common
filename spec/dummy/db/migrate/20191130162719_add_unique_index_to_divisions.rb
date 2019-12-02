class AddUniqueIndexToDivisions < ActiveRecord::Migration[5.2]
  def change
    add_index :divisions, :name, unique: true, where: 'division_status = 0'
  end
end
