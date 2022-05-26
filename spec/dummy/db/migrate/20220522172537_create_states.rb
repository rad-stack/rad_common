class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :code, null: false
      t.string :name, null: false

      t.index :code, unique: true
      t.index :name, unique: true

      t.timestamps
    end

    migrate_state 'companies', true
    migrate_state 'attorneys', true
  end

  private

    def migrate_state(table_name, required)
      rename_column table_name, :state, :old_state
      add_column table_name, :state_id, :integer

      add_index table_name, :state_id
      add_foreign_key table_name, :states

      if execute("SELECT COUNT(*) FROM #{table_name}").count.positive?
        RadSeeder.new.send(:seed_states)

        execute <<-SQL
          UPDATE #{table_name}
          SET state_id = states.id
          FROM states
          WHERE #{table_name}.old_state = states.code;
        SQL
      end

      change_column_null(table_name, :state_id, false) if required
      remove_column table_name, :old_state
    end
end
