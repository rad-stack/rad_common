class AddCategoriesToDivisions < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps

      t.index :name, unique: true
    end

    add_reference :divisions, :category, foreign_key: true
  end
end
