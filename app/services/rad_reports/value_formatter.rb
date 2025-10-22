module RadReports
  class ValueFormatter
    def self.format_record_value(record, select_clause, column_def = nil)
      if column_def && column_def[:is_attachment]
        return format_attachment_value(record, column_def[:name])
      end

      value = extract_value(record, select_clause, column_def)

      # Apply formula transformations if present
      if column_def && column_def[:formula].present?
        FormulaProcessor.call(column_def[:formula], value, record)
      else
        value
      end
    end

    def self.extract_value(record, select_clause, _column_def = nil)
      actual_column = select_clause.to_s.gsub('.', '_')
      column_name = select_clause.to_s.split('.').last

      [actual_column, column_name].uniq.each do |col|
        return record.public_send(col) if record.respond_to?(col)
        return record[col] || record[col.to_s] if record.respond_to?(:[]) && (record[col] || record[col.to_s])
      end

      nil
    end

    def self.format_attachment_value(_record, _attachment_name)
      nil
    end
  end
end
