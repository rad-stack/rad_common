module RadCommon
  class SearchFilter
    attr_reader :options, :column, :joins, :scopes, :multiple, :scope

    def initialize(column: nil, options:, scopes: nil, joins: nil, input_label: nil, blank_value_label: nil, scope: nil, multiple: false)
      @column = column
      @options = options
      @joins = joins
      @input_label = input_label
      @blank_value_label = blank_value_label
      @scopes = scopes
      @scope = scope
      @multiple = multiple
    end

    def input_options
      if @scopes.present?
        scope_options = @scopes.keys.map { |option| [option, option]}
        scope_options + options.map { |option| [option.to_s, option.id] }
      else
        options
      end
    end

    def apply_filter(results, value)
      if scope_search?
        apply_scope_filter(results, value)
      elsif scope_value?(value)
        apply_scope_value(results, value)
      elsif value.present?
        if value.is_a? Array
          values = value.select(&:present?).map(&:to_i)
          results.where("#{searchable_name} IN (?)", values) if values.present?
        else
          results.where("#{searchable_name} = ?", value)
        end
      end
    end

    def scope_search?
      scope.present?
    end

    def scope_value?(scope_name)
      scopes.present? && scopes.has_key?(scope_name)
    end

    def apply_scope_value(results, scope_name)
      scope = scopes[scope_name]
      scope_name = scope.keys.first
      scope_args = scope[scope_name]
      results.send(scope_name, scope_args)
    end

    def apply_scope_filter(results, value)
      results.send(scope, value)
    end

    def searchable_name
      @scope || @column
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
      options.first.is_a?(Array) ? :grouped_select : :select
    end
  end
end