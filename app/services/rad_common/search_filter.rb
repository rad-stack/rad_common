module RadCommon
  ##
  # This is used to generate dropdown filter containing options to be filtered on
  class SearchFilter
    attr_reader :options, :column, :joins, :scope_values, :multiple, :scope, :default_value, :errors, :include_blank,
                :search_scope, :search_class

    ##
    # @param [Symbol optional] column the database column that is being filtered
    # @param [Symbol optional] name an identifying named to be used for inputs. This is only used
    #   in conjunction with scope_values instead of column
    # @param [ActiveRecord_Relation, Array] options the options to be displayed in the dropdown. See examples
    #   This is required when no scope values are specified.
    # @param [Boolean optional] grouped will the options be grouped
    # @param [Array optional] scope_values An array of scopes active record scopes represented by symbols to be inserted
    #   into the dropdown options.For example :closed_orders, :open_orders. This is required when no options are specified.
    # @param [String optional] joins any necessary sql joins so that the query can be performed
    # @param [String optional] input_label by default the input label for the dropdown is determined by the column name
    #   but you can override that by specifying it here
    # @param [Object optional] default_value the default value selected in the dropdown options
    # @param [String optional] blank_value_label the text displayed in the dropdown when there is no value selected.
    #   By default this is calculated based on the query model name but can be overidden here
    # @param [Symbol optional] scope an active record scope to apply the filter to.
    # @param [Boolean optional] multiple when set to true the dropdown becomes a multiple select
    #
    # @example active record list
    #   [{column: :user_id, options: User.all}]
    # @example Two dimensional array options
    #   [{column: :my_column, options: [['Option 1', 1],['Option 2', 2], ['Option 3', 3]]}]
    # @example Grouped options mixed with scoped values
    #   [{ column: :owner_id, input_label: 'Users', grouped: true,
    #      options: [['...', [user, { scope_value: :unassigned }]],
    #               ['Active', User.active.by_name],
    #               ['Inactive', User.inactive.by_name]] }]
    # @example Using scope values
    #   [{ column: :owner_id, options: User.by_name, scope_values: { 'Pending Values': :pending } }]
    def initialize(column: nil, name: nil, options: nil, grouped: false, scope_values: nil, joins: nil, input_label: nil,
                   default_value: nil, blank_value_label: nil, scope: nil, multiple: false, required: false,
                   include_blank: true, search_scope: nil, search_class: nil)
      if input_label.blank? && !options.respond_to?(:table_name)
        raise 'Input label is required when options are not active record objects'
      end

      raise 'options or scope_values' if options.nil? && scope_values.nil?
      raise 'name is only valid when scope_values are present' if name.present? && scope_values.blank?
      raise 'must have a column, name, or scope defined' if column.blank? && name.blank? && scope.blank?

      @name = name
      @column = column
      @options = options
      @joins = joins
      @input_label = input_label
      @include_blank = include_blank
      @blank_value_label = blank_value_label
      @scope_values = scope_values
      @scope = scope
      @multiple = multiple
      @default_value = default_value
      @grouped = grouped
      @required = required
      @search_scope = search_scope
      @search_class = search_class
      @errors = []
    end

    # @return [String] the name of the view to be used to render the filter input
    def filter_view
      'select'
    end

    def searchable_name
      scope_name || @column || @name
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

    # @return input options for the select html input.
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

    def input_options_with_current_selection(search)
      return input_options unless search_scope.present? && search_class.present?

      input_options + search_class.where(id: selected_value(search)).to_a
    end

    # @return the method that simple form should use to determine the label of the select option
    def label_method
      return :first if grouped_scope_values?
      return :to_s if @grouped

      @scope_values.present? || options.first.is_a?(Array) ? :first : :to_s
    end

    # Applies the filter to the result set
    # @param results active record results query
    # @param search_params the url params from the search
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

    def selected_value(search)
      search.selected_value(searchable_name) || default_value
    end

    def validate_params(params)
      if @required && filter_value(params).blank?
        @errors = ["#{input_label} is required"]
        false
      else
        true
      end
    end

    def search_scope_params
      {
        class: 'selectpicker-search',
        'data-abs-ajax-data' => {
          'global_search_scope' => search_scope,
          'term' => '{{{q}}}'
        }.to_json
      }
    end

    private

      def scope_name
        return if @scope.blank?

        @scope.is_a?(Hash) ? @scope.keys.first : @scope
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

      def query_column(results)
        return searchable_name if searchable_name.respond_to?(:split) && searchable_name.split('.').length > 1

        "#{results.table_name}.#{searchable_name}"
      end

      def convert_array_values(value)
        value.select(&:present?).map(&:to_i)
      end

      def filter_value(search_params)
        return @default_value.to_s if search_params.blank? && @default_value

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
        return false unless @grouped

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
