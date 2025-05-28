class GlobalAutocomplete
  include RadCommon::ApplicationHelper

  attr_reader :params, :search_scopes, :user, :mode
  attr_accessor :current_scope

  def initialize(params, search_scopes, user, mode)
    @params = params
    @search_scopes = search_scopes
    @current_scope = selected_scope
    @mode = mode
    validate_global_search_scope
    @user = user
  end

  def global_autocomplete_result
    return [] if search_scopes.empty?

    autocomplete_result(selected_scope)
  end

  def global_super_search_result
    raise 'excluded_ids not applicable for super search' if params[:excluded_ids].present?

    scopes = search_scopes.select { |scope| scope_with_where?(scope) }

    results = scopes.map do |scope|
      result = autocomplete_result(scope) unless scope[:super_search_exclude]
      result
    end

    results = results.compact.flatten
    results.uniq { |result| [result[:model_name], result[:id]] }
  end

  def base_autocomplete_collection(scope)
    return [] unless scope && policy_ok?

    self.current_scope = scope
    order = scope[:query_order] || 'created_at DESC'
    query = Pundit.policy_scope!(user, check_policy_klass(klass))
    query = query.joins(joins) if joins
    query.order(order)
  end

  private

    def autocomplete_result(scope)
      query = base_autocomplete_collection(scope)
      return [] if query.empty?

      query = query.where(where_query, search: "%#{params[:term]}%")

      if params[:excluded_ids].present?
        # TODO: this will fail when scope has joins due to ambiguous id column
        # it's not too bad a fix but also unlikely we'll hit the scenario any time soon
        query = query.where.not(id: params[:excluded_ids])
      end

      query = query.limit(params[:limit].presence || 50)
      search_label = scope[:search_label] || :to_s

      query.map do |record|
        { columns: get_columns_values(columns, methods, record),
          model_name: klass.name,
          human_name: klass.model_name.human,
          id: record.id,
          label: record.send(search_label),
          value: record.to_s,
          active: !record.respond_to?(:active?) || record.active?,
          scope_description: scope[:description] }
      end
    end

    def get_columns_values(columns, methods, record)
      column_values = []

      if columns.present?
        columns.each do |column_name|
          column_values.push(format_column_value(record[column_name]))
        end
      end

      if methods.present?
        methods.each do |method_name|
          column_values.push(format_column_value(record.send(method_name)))
        end
      end

      column_values
    end

    def format_column_value(value)
      if value.blank?
        ''
      elsif value.is_a? ActiveSupport::TimeWithZone
        format_datetime(value)
      elsif value.is_a? Date
        format_date(value)
      elsif value.is_a?(ActiveRecord::Base)
        value.to_s
      else
        value
      end
    end

    def scope_name
      params[:global_search_scope].presence || search_scopes.first[:name]
    end

    def validate_global_search_scope
      return if params[:global_search_scope].blank?

      raise "Invalid global scope #{params[:global_search_scope]}" if selected_scope.blank?
    end

    def selected_scope
      search_scopes.detect { |item| item[:name] == scope_name } if search_scopes.any?
    end

    def where_query
      return current_scope[:query_where] if current_scope[:query_where]

      where_items = []

      columns.each do |column|
        if data_type(column) == :text && array?(column)
          where_items.push("ARRAY_TO_STRING(#{column}, '') LIKE :search")
        elsif data_type(column) == :string || data_type(column) == :text
          where_items.push("#{column} ILIKE :search")
        elsif data_type(column) == :date
          where_items.push("to_char(#{column}, 'FMMM/FMDD/YYYY') LIKE :search")
        else
          where_items.push("CAST(#{column} AS TEXT) LIKE :search")
        end
      end
      where_items.join(' OR ')
    end

    def klass
      current_scope[:model].constantize
    end

    def columns
      current_scope[:columns]
    end

    def joins
      current_scope[:joins]
    end

    def methods
      current_scope[:methods]
    end

    def data_type(column)
      klass.new.has_attribute?(column) ? column_def(column).type : :string
    end

    def array?(column)
      klass.new.has_attribute?(column) ? column_def(column).array : false
    end

    def column_def(column)
      klass.new.column_for_attribute(column)
    end

    def scope_with_where?(scope)
      (scope[:columns].present? && scope[:columns].any?) || scope[:query_where].present?
    end

    def policy_ok?
      if mode == :global_search
        Pundit.policy!(user, check_policy_klass(klass.new)).global_search?
      elsif mode == :searchable_association
        Pundit.policy!(user, check_policy_klass(klass.new)).searchable_association?
      else
        raise "invalid mode: #{mode}"
      end
    end

    def check_policy_klass(context)
      if user.external? && RadConfig.portal?
        [:portal, context]
      else
        context
      end
    end
end
