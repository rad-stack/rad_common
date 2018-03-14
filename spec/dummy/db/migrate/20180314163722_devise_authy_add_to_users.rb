class DeviseAuthyAddToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|
      t.string    :authy_id, references: nil
      t.datetime  :last_sign_in_with_authy
      t.boolean   :authy_enabled, null: false, default: true
    end

    add_index :users, :authy_id
  end

  def self.down
    change_table :users do |t|
      t.remove :authy_id, :last_sign_in_with_authy, :authy_enabled
    end
  end
end
