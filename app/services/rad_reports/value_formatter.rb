module RadReports
  class ValueFormatter
    def self.format_record_value(record, column_def)
      return if column_def[:is_attachment]

      value = extract_value(record, column_def)
      return FormulaProcessor.call(column_def[:formula], value, record) if column_def[:formula].present?

      value
    end

    def self.extract_value(record, column_def)
      lookup_path = [column_def[:select].to_s.gsub('.', '_'), column_def[:name]].uniq

      lookup_path.each do |col|
        return record.public_send(col) if col.present? && record.respond_to?(col)
        return record[col] if record[col].present?
      end

      nil
    end
  end
end
