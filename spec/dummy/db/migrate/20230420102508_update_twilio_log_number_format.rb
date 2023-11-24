class UpdateTwilioLogNumberFormat < ActiveRecord::Migration[6.1]
  def up
    execute <<~SQL
      UPDATE twilio_logs
      SET from_number = '(' || substr(from_number_without_prefix, 1, 3) || ') ' || substr(from_number_without_prefix, 4, 3) || '-' || substr(from_number_without_prefix, 7, 4),
          to_number = '(' || substr(to_number_without_prefix, 1, 3) || ') ' || substr(to_number_without_prefix, 4, 3) || '-' || substr(to_number_without_prefix, 7, 4)
      FROM (
        SELECT id, 
          CASE 
            WHEN length(regexp_replace(from_number, '^\\+?1', '')) = 10 THEN regexp_replace(from_number, '^\\+?1', '') 
            ELSE from_number
          END AS from_number_without_prefix, 
          CASE 
            WHEN length(regexp_replace(to_number, '^\\+?1', '')) = 10 THEN regexp_replace(to_number, '^\\+?1', '') 
            ELSE to_number
          END AS to_number_without_prefix
        FROM twilio_logs
      ) AS twilio_logs_without_prefix
      WHERE twilio_logs.id = twilio_logs_without_prefix.id;
    SQL
  end

  def down; end
end
