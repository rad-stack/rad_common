class MoreTestData < ActiveRecord::Migration[5.0]
  def change
    create_table :divisions do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :owner_id, null: false, references: :users

      t.timestamps
    end
  end
end
