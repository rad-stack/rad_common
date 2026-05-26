class BackfillContactLogContactDirection < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def up
    loop do
      updated = ContactLog.where(contact_direction: nil)
                          .limit(10_000)
                          .update_all(contact_direction: ContactLog.contact_directions[:outgoing])
      break if updated.zero?
    end

    change_column_null :contact_logs, :contact_direction, false
  end

  def down
    change_column_null :contact_logs, :contact_direction, true
  end
end
