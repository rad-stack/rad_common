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
        format_currency(value)
      when :number
        value.is_a?(Numeric) ? value.to_s(:delimited) : value
      when :percentage
        value.is_a?(Numeric) ? "#{value}%" : value
      when :boolean
        format_boolean(value)
      else
        value
      end
    end

    def self.format_record_value(record, column_name, column_def = nil)
      value = extract_value(record, column_name)
      column_def ? call(column_def, value) : value
    end

    def self.extract_value(record, column_name)
      if record.respond_to?(column_name)
        record.public_send(column_name)
      elsif record.respond_to?(:[])
        record[column_name] || record[column_name.to_s]
      else
        nil
      end
    end
  end
end
