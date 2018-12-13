class DatabaseUseChecker
  class << self
    def generate_report
      Rails.logger.silence do
        tables.each do |table_name|
          table_report(table_name) unless zero_or_one_records?(table_name)
        end
      end
      'Report Generated! The above table columns are candidates for deletion.'
    end

    def tables
      ActiveRecord::Base.connection.tables - ['schema_migrations']
    end

    def zero_or_one_records?(table_name)
      num_records = record_count(table_name)

      puts "Table #{table_name}\n  No Records" if num_records == 0
      num_records == 1 || num_records == 0
    end

    def record_count(table_name)
      count = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM #{table_name}")
      count.first['count'].to_i
    end

    def table_report(table_name)
      puts "Table #{table_name}" if table_has_columns_eligible_for_deletion?(table_name)

      table_columns(table_name).each do |column|
        review_column(table_name, column)
      end
    end

    def table_has_columns_eligible_for_deletion?(table_name)
      table_columns(table_name).any? do |column|
        values = column_values(table_name, column)
        values.all?(&:blank?) || values.size == 1
      end
    end

    def table_columns(table_name)
      ActiveRecord::Base.connection.columns(table_name).map(&:name)
    end

    def review_column(table_name, column)
      values = column_values(table_name, column)

      case
      when values.all?(&:blank?)
        puts "  Blank: #{table_name}##{column}"
      when values.size == 1
        puts "  Identical Values: #{table_name}##{column}"
      end
    end

    def column_values(table_name, column)
      ActiveRecord::Base.connection.execute("SELECT DISTINCT #{column} FROM #{table_name}").values.flatten
    end
  end
end
