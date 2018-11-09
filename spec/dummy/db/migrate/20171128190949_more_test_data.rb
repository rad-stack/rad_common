class MoreTestData < ActiveRecord::Migration[5.0]
  def change
    create_table :divisions do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :owner, references: :users, null: false

      t.timestamps
    end

    add_foreign_key :divisions, :users, column: :owner_id
  end
end
