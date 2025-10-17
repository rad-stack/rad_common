module RadReports
  class ValueFormatter
    class << self
      include RadHelper
    end

    def self.call(column_def, value)
      return '' if value.nil?
      return value unless column_def

      case column_def[:format].to_sym
      when :date
        format_date(value)
      when :datetime
        format_datetime(value)
      when :currency
        ApplicationController.helpers.number_to_currency(value)
      when :number
        value.is_a?(Numeric) ? value.to_s : value
      when :percentage
        value.is_a?(Numeric) ? "#{value}%" : value
      when :boolean
        format_boolean(value)
      else
        value
      end
    end

    def self.format_record_value(record, select_clause, column_def = nil)
      value = extract_value(record, select_clause, column_def)
      column_def ? call(column_def, value) : value
    end

    def self.extract_value(record, select_clause, column_def = nil)
      actual_column = select_clause.to_s.gsub('.', '_')
      column_name = select_clause.to_s.split('.').last

      [actual_column, column_name].uniq.each do |col|
        return record.public_send(col) if record.respond_to?(col)
        return record[col] || record[col.to_s] if record.respond_to?(:[]) && (record[col] || record[col.to_s])
      end

      nil
    end
  end
end
