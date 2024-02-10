module RadTable
  class Column
    attr_reader :name, :hidden, :options, :value_path, :value_parser, :helper, :rad_table

    delegate :view_context, to: :rad_table, allow_nil: true

    def initialize(name, hidden: false, value_path: nil, value_parser: nil, helper: nil, **options)
      @name = name
      @hidden = hidden
      @options = options
      @value_path = value_path
      @value_parser = value_parser
      @helper = helper
    end

    def render(record)
      raise 'cannot render without a table attached' if rad_table.nil?

      value = extract_value(record)
      format_value(value)
    end

    def attach_table(rad_table)
      @rad_table = rad_table
    end

    def toggleable?
      options.key?(:toggleable) ? options[:toggleable] : true
    end

    def header
      options[:header].presence || name.to_s.titleize
    end

    private

      def extract_value(record)
        return record.public_send(value_path) if value_path.present?
        return value_parser.call(record) if value_parser.present?
        return view_context.public_send(helper, record) if helper.present? && !helper.is_a?(Array)

        if helper.is_a?(Array)
          value = record
          helper.each do |nested_helper|
            value = view_context.public_send(nested_helper, value)
          end
          return value
        end

        record.public_send(name)
      end

      def format_value(value)
        value.to_s
      end
  end
end
