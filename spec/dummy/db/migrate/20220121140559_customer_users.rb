class CustomerUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.text :valid_user_domains, default: [], null: false, array: true

      t.index :name

      t.timestamps
    end

    create_table :user_customers do |t|
      t.integer :user_id, null: false
      t.integer :customer_id, null: false

      t.timestamps

      t.index %i[user_id customer_id], unique: true
    end

    add_foreign_key :user_customers, :users
    add_foreign_key :user_customers, :customers
  end
end
