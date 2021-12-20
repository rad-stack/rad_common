class SecurityGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :super_admin, :boolean, null: false, default: false

    create_table :security_groups do |t|
      t.string :name, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :security_groups, :name, unique: true

    add_column :users, :security_group_id, :integer, null: false
  end
end
