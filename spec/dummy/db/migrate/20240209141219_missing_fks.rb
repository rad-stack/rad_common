class MissingFks < ActiveRecord::Migration[7.0]
  def change
    unless foreign_key_exists?(:audits, :users)
      add_foreign_key :audits, :users
    end

    if RadConfig.user_clients?
      unless foreign_key_exists?(:user_clients, :clients)
        # you may need to change the table name of :clients
        add_foreign_key :user_clients, :clients
      end
    end
  end
end
