class CreateUserClients < ActiveRecord::Migration[6.1]
  def change
    if RadConfig.user_clients?
      create_table :clients do |t|
        t.string :name, null: false
        t.boolean :active, null: false, default: true
        t.text :valid_user_domains, default: [], null: false, array: true

        t.index :name

        t.timestamps
      end
    end

    create_table :user_clients do |t|
      t.integer :user_id, null: false
      t.integer :client_id, null: false

      t.timestamps

      t.index %i[user_id client_id], unique: true
    end

    add_foreign_key :user_clients, :users

    if RadConfig.user_clients?
      add_foreign_key :user_clients, :clients
    end
  end
end
