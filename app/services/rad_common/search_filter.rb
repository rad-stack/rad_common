module RadCommon
  class SearchFilter
    attr_reader :options, :column, :joins, :scope_values, :multiple, :scope

    def initialize(column: nil, options: nil, scope_values: nil, joins: nil, input_label: nil, blank_value_label: nil, scope: nil, multiple: false)
      raise 'Input label is required when options are not active record objects' if input_label.blank? && !options.respond_to?(:table_name)
      raise 'options or scope_values' if options.nil? && scope_values.nil?

      @column = column
      @options = options
      @joins = joins
      @input_label = input_label
      @blank_value_label = blank_value_label
      @scope_values = scope_values
      @scope = scope
      @multiple = multiple
      @grouped = false #todo make group select work
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
      if scope_values?
        scope_options = if @scope_values.is_a? Array
                          @scope_values.map { |option| [option.to_s.titleize, option.to_s]}
                        else
                          @scope_values.keys.map { |option| [option, option] }
                        end
        scope_options += options.map { |option| [option.to_s, option.id] } if options.present?
        scope_options
      else
        options
      end
    end

    def label_method
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
          results.where("#{results.table_name}.#{searchable_name} = ?", value)
        end
      end
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
        if scope_name.present? && @scope_values.present?
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
        if @scope_values.is_a? Hash
          apply_scope_h_value(results, scope_name)
        elsif @scope_values.is_a? Array
          apply_scope_a_value(results, scope_name)
        end
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