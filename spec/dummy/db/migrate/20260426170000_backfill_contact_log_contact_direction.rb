class BackfillContactLogContactDirection < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!

  def up
    # Email and voice service_types were previously created with contact_direction = NULL.
    # Email was forbidden by validation; voice had no rule and was left blank by convention.
    # We are tightening the rule to require contact_direction on every ContactLog, so
    # backfill the historical NULLs to outgoing (the only direction those service_types
    # have ever been used for) and then enforce NOT NULL.
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
