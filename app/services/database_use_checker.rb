class DatabaseUseChecker
  class << self
    def generate_report
      if Rails.env.test?
        tables.each do |table_name|
          table_report(table_name) unless zero_or_one_records?(table_name)
        end
      else
        Rails.logger.silence do
          tables.each do |table_name|
            table_report(table_name) unless zero_or_one_records?(table_name)
          end
        end
      end

      'Report Generated! The above table columns are candidates for deletion.'
    end

    def tables
      AppInfo.new.application_tables - AppInfo.new.rad_common_tables
    end

    def zero_or_one_records?(table_name)
      num_records = record_count(table_name)

      puts ''
      puts "Table #{table_name}\n  No Records" if num_records.zero?
      num_records == 1 || num_records.zero?
    end

    def record_count(table_name)
      count = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM #{table_name}")
      count.first['count'].to_i
    end

    def table_report(table_name)
      puts "Table #{table_name} " \
           "(last created #{last_created(table_name)}, " \
           "last updated #{last_updated(table_name)}, " \
           "record count: #{record_count(table_name)})"

      table_columns(table_name).each do |column|
        review_column(table_name, column)
      end
    end

    def table_columns(table_name)
      ActiveRecord::Base.connection.columns(table_name).map(&:name)
    end

    def review_column(table_name, column)
      values = column_values(table_name, column)

      if values.all?(&:blank?)
        puts "  Blank: #{table_name}##{column}"
      elsif values.size == 1
        puts "  Identical Values: #{table_name}##{column}"
      end
    end

    def last_created(table_name)
      return 'n/a' unless ActiveRecord::Base.connection.column_exists?(table_name, :created_at)

      format_date ActiveRecord::Base.connection.execute("SELECT MAX(created_at) FROM #{table_name}").values.first.first
    end

    def last_updated(table_name)
      return 'n/a' unless ActiveRecord::Base.connection.column_exists?(table_name, :updated_at)

      format_date ActiveRecord::Base.connection.execute("SELECT MAX(updated_at) FROM #{table_name}").values.first.first
    end

    def column_values(table_name, column)
      ActiveRecord::Base.connection.execute("SELECT DISTINCT \"#{column}\" FROM #{table_name}").values.flatten
    end

    def format_date(value)
      ApplicationController.helpers.format_date(value)
    end
  end
end
