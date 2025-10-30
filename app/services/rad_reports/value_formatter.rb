module RadReports
  class ValueFormatter
    def self.format_record_value(record, column_def)
      return if column_def[:is_attachment]

      # Extract value from record (works for both regular and calculated columns)
      value = extract_value(record, column_def)

      if column_def[:formula].present?
        transforms = if column_def[:is_calculated]
                       Array(column_def[:formula]).drop(1)
                     else
                       column_def[:formula]
                     end

        return FormulaProcessor.call(transforms, value, record) if transforms.any?
      end

      value
    end

    def self.extract_value(record, column_def)
      lookup_path = if column_def[:is_calculated]
                      [column_def[:name].to_s.gsub('.', '_'), column_def[:name]]
                    else
                      [column_def[:select].to_s.gsub('.', '_'), column_def[:name]]
                    end.uniq

      lookup_path.each do |col|
        return record.public_send(col) if col.present? && record.respond_to?(col)
        return record[col] if record[col].present?
      end

      nil
    end
  end
end
