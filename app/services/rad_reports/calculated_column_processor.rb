module RadReports
  class CalculatedColumnProcessor
    def self.extract_column_value(record, column_path)
      return nil if column_path.blank? || record.blank?

      return record.public_send(column_path) if record.respond_to?(column_path)
      return record[column_path.to_s] if record.respond_to?(:[]) && record[column_path.to_s]

      # Handle nested column paths (e.g., "users.first_name" -> "users_first_name")
      aliased_column = column_path.to_s.gsub('.', '_')
      return record[aliased_column] if record.respond_to?(:[]) && record[aliased_column]

      # Handle base table column references like "users.first_name"
      if record.respond_to?(:class) && record.class.respond_to?(:table_name)
        base_table = record.class.table_name
        if base_table.present? && column_path.to_s.start_with?("#{base_table}.")
          column_name = column_path.to_s.split('.').last
          return record.public_send(column_name) if record.respond_to?(column_name)
          return record[column_name] if record.respond_to?(:[]) && record[column_name]
        end
      end

      # Handle association access (e.g., "user.first_name")
      if column_path.include?('.')
        parts = column_path.split('.')
        current = record

        parts.each do |part|
          if current.respond_to?(part)
            current = current.public_send(part)
          elsif current.respond_to?(:[])
            current = current[part]
          else
            return nil
          end

          return nil if current.nil?
        end

        return current
      end

      nil
    end
  end
end
