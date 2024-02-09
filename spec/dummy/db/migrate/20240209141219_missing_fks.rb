class MissingFks < ActiveRecord::Migration[7.0]
  def change
    unless foreign_key_exists?(:audits, :users)
      add_foreign_key :audits, :users
    end

    unless foreign_key_exists?(:user_clients, :clients)
      add_foreign_key :user_clients, :clients
    end
  end
end
