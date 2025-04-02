module RadCommon
  ##
  # This is used to generate dropdown filter containing options to be filtered on
  class SearchFilter
    attr_reader :options, :column, :joins, :scope_values, :multiple, :scope, :not_scope,
                :default_value, :errors, :include_blank, :col_class,
                :search_scope, :show_search_subtext, :allow_not

    ##
    # @param [Symbol optional] column the database column that is being filtered
    # @param [Symbol optional] name an identifying named to be used for inputs. This is only used
    #   in conjunction with scope_values instead of column
    # @param [ActiveRecord_Relation, Array] options the options to be displayed in the dropdown. See examples
    #   This is required when no scope values are specified.
    # @param [Boolean optional] grouped will the options be grouped
    # @param [Array optional] scope_values An array of active record scope names as as selectable values represented
    #   by symbols to be inserted into the dropdown options. For example :closed_orders, :open_orders.
    #   This is required when no options are specified.
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
    #               ['Active', User.active.sorted],
    #               ['Inactive', User.inactive.sorted]] }]
    # @example Using scope with grouped options
    #   { input_label: 'Sales User',
    #     scope: :for_sales_user,
    #     options: [['Active', User.active.sorted],
    #               ['Inactive', User.inactive.sorted]],
    #     grouped: true,
    #     blank_value_label: 'All Users' }
    # @example Using scope values
    #   [{ column: :owner_id, options: User.sorted, scope_values: { 'Pending Values': :pending } }]
    def initialize(column: nil, name: nil, options: nil, grouped: false, scope_values: nil, joins: nil,
                   input_label: nil, default_value: nil, blank_value_label: nil, scope: nil, not_scope: nil,
                   multiple: false, required: false, include_blank: true, col_class: nil, search_scope_name: nil,
                   show_search_subtext: false, allow_not: false)
      if input_label.blank? && !options.respond_to?(:table_name)
        raise 'Input label is required when options are not active record objects'
      end

      if scope.present? && allow_not && not_scope.blank?
        raise 'not_scope is required when scope and allow_not are present'
      end
      raise 'options, scope_values, or search_scope' if options.nil? && scope_values.nil? && search_scope_name.nil?
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
      @not_scope = not_scope
      @multiple = multiple
      @default_value = default_value
      @grouped = grouped
      @required = required
      @col_class = col_class
      @search_scope = RadConfig.global_search_scopes!.find { |s| s[:name] == search_scope_name }
      @show_search_subtext = show_search_subtext
      @allow_not = allow_not
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
        options.presence || []
      end
    end

    def input_options_with_current_selection(search)
      return input_options if search_scope.blank?

      input_options + search_scope[:model].constantize.where(id: selected_value(search)).to_a
    end

    # @return the method that simple form should use to determine the label of the select option
    def label_method
      return search_scope[:search_label].presence || :to_s if search_scope.present?
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
        apply_scope_filter(results, value, search_params)
      elsif scope_value?(value)
        apply_scope_value(results, value)
      elsif value.present?
        not_filter = not_value?(search_params)
        if value.is_a? Array
          values = convert_array_values(value)
          return if values.blank?

          query = not_filter ? "#{query_column(results)} NOT IN (?)" : "#{query_column(results)} IN (?)"
          results.where(query, values)
        else
          query = "#{query_column(results)} = ?"
          not_filter ? results.where.not(query, value) : results.where(query, value)
        end
      end
    end

    def selected_value(search)
      search.selected_value(searchable_name) || default_value
    end

    def validate_params(params)
      return true unless @required

      value = filter_value(params)
      value = value.compact_blank if value.is_a?(Array)
      return true if value.present?

      @errors = ["#{input_label} is required"]
      false
    end

    def search_scope_params
      {
        class: 'selectpicker-search',
        'data-subtext' => show_search_subtext,
        'data-placeholder' => search_scope[:description],
        'data-global-search-scope' => search_scope[:name],
        'data-global-search-mode' => 'searchable_association'
      }
    end

    def not_value?(search_params)
      allow_not && search_params && search_params["#{searchable_name}_not"] == '1'
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
        values = value.select(&:present?)
        return values.map(&:to_i) if number_array?(values)

        values
      end

      def number_array?(values)
        values.all? { |v| Integer(v, exception: false) }
      end

      def filter_value(search_params)
        search_empty = (search_params.blank? || !search_params.has_key?(searchable_name))
        return @default_value.to_s if search_empty && @default_value

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

        return values.intersect?(value.map(&:to_sym).reject(&:blank?)) if value.is_a?(Array)

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

      def apply_scope_filter(results, value, search_params)
        if scope.is_a? Hash
          scope_proc = scope.values.first
          scope_proc.call(results, value)
        else
          value = convert_array_values(value) if value.is_a? Array
          results.send(not_value?(search_params) ? not_scope : scope, value) if value.present?
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
        return apply_mixed_group_scope_values(results, scope_name) if scope_name.is_a?(Array)

        results.send(scope_name)
      end

      def apply_mixed_group_scope_values(results, values)
        scopes = grouped_scope_values.intersection(values.map(&:to_sym))
        values = (values.compact - scopes.map(&:to_s)).reject(&:blank?)
        results = results.where("#{searchable_name} IN (?)", values) if values.present?
        scopes.each { |scope| results = results.send(scope) }

        results
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
