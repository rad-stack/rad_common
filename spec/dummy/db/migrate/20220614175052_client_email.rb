class ClientEmail < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :email, :string, null: false
  end
end
