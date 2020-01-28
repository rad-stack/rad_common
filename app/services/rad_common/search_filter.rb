module RadCommon
  class SearchFilter
    attr_reader :options, :column, :joins, :scope_values, :multiple, :scope, :default_value

    def initialize(column: nil, options: nil, grouped: false, scope_values: nil, joins: nil, input_label: nil, default_value: nil, blank_value_label: nil, scope: nil, multiple: false)
      if input_label.blank? && !options.respond_to?(:table_name)
        raise 'Input label is required when options are not active record objects'
      end

      raise 'options or scope_values' if options.nil? && scope_values.nil?

      @column = column
      @options = options
      @joins = joins
      @input_label = input_label
      @blank_value_label = blank_value_label
      @scope_values = scope_values
      @scope = scope
      @multiple = multiple
      @default_value = default_value
      @grouped = grouped
    end

    def filter_view
      'select'
    end

    def searchable_name
      scope_name || @column
    end

    def scope_name
      return if @scope.blank?

      @scope.is_a?(Hash) ? @scope.keys.first : @scope
    end

    def blank_value_label
      @blank_value_label || "All #{model_name.pluralize}"
    end

    def input_label
      @input_label || model_name
    end

    def model_name
      @input_label || options.table_name.titleize.singularize
    end

    def input_type
      @grouped ? :grouped_select : :select
    end

    def input_options
      if grouped_scope_values?
        options.map do |option|
          group_key = option.first
          group_options = option.second
          [group_key, transform_group_options(group_options)]
        end
      elsif scope_values?
        scope_options = if @scope_values.is_a? Array
                          @scope_values.map { |option| [option.to_s.titleize, option.to_s] }
                        else
                          @scope_values.keys.map { |option| [option.to_s, option.to_s] }
                        end
        scope_options += options.map { |option| [option.to_s, option.id] } if options.present?
        scope_options
      else
        options
      end
    end

    def transform_group_options(group_options)
      group_options.map do |option|
        if scope_value_option?(option)
          [option[:scope_value].to_s.titleize, option[:scope_value].to_s]
        else
          [option.to_s, option.id]
        end
      end
    end

    def label_method
      return :first if grouped_scope_values?
      return :to_s if @grouped

      @scope_values.present? || options.first.is_a?(Array) ? :first : :to_s
    end

    def apply_filter(results, search_params)
      value = filter_value(search_params)
      if scope_search?
        apply_scope_filter(results, value)
      elsif scope_value?(value)
        apply_scope_value(results, value)
      elsif value.present?
        if value.is_a? Array
          values = convert_array_values(value)
          results.where("#{searchable_name} IN (?)", values) if values.present?
        else
          results.where("#{query_column(results)} = ?", value)
        end
      end
    end

    def query_column(results)
      return searchable_name if searchable_name.respond_to?(:split) && searchable_name.split('.').length > 1

      "#{results.table_name}.#{searchable_name}"
    end

    def convert_array_values(value)
      value.select(&:present?).map(&:to_i)
    end

    private

      def filter_value(search_params)
        search_params[searchable_name]
      end

      def scope_values?
        @scope_values.present?
      end

      def grouped_scope_values?
        @grouped && grouped_scope_values.present?
      end

      def grouped_scope_values
        all_group_values.select(&method(:scope_value_option?)).map { |option| option[:scope_value] }
      end

      def grouped_scope_value?(value)
        values = grouped_scope_values
        return false if values.blank?

        values.include?(value.to_sym)
      end

      def scope_value_option?(option)
        option.is_a?(Hash) && option.keys.include?(:scope_value)
      end

      def all_group_values
        options.map(&:second).flatten
      end

      def scope_search?
        scope.present?
      end

      def apply_scope_filter(results, value)
        if scope.is_a? Hash
          scope_proc = scope.values.first
          scope_proc.call(results, value)
        else
          value = convert_array_values(value) if value.is_a? Array
          results.send(scope, value) if value.present?
        end
      end

      def scope_value?(scope_name)
        return false if scope_name.blank?
        return true if grouped_scope_value?(scope_name)

        if @scope_values.present? && scope_name.is_a?(String)
          if @scope_values.is_a? Array
            @scope_values.include?(scope_name.to_sym)
          else
            @scope_values.symbolize_keys.has_key?(scope_name.to_sym)
          end
        else
          false
        end
      end

      def apply_scope_value(results, scope_name)
        if grouped_scope_values?
          apply_scope_grouped_value(results, scope_name)
        elsif @scope_values.is_a? Hash
          apply_scope_h_value(results, scope_name)
        elsif @scope_values.is_a? Array
          apply_scope_a_value(results, scope_name)
        end
      end

      def apply_scope_grouped_value(results, scope_name)
        results.send(scope_name)
      end

      def apply_scope_a_value(results, scope_name)
        results.send(scope_name) if @scope_values.include?(scope_name.to_sym)
      end

      def apply_scope_h_value(results, scope_name)
        scope = @scope_values.symbolize_keys[scope_name.to_sym]
        if scope.is_a? Symbol
          results.send(scope)
        else
          scope_name = scope.keys.first
          scope_args = scope[scope_name]
          results.send(scope_name, scope_args)
        end
      end
  end
end
