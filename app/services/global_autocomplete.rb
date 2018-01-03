class GlobalAutocomplete
  include RadCommon::ApplicationHelper

  attr_reader :params, :search_scopes, :member
  attr_accessor :current_scope
  def initialize(params, search_scopes, member)
    @params = params
    @search_scopes = search_scopes
    @current_scope = selected_scope
    @member = member
  end

  def global_autocomplete_result
    return [] if search_scopes.empty?
    autocomplete_result(selected_scope)
  end

  def global_super_search_result
    scopes = search_scopes.select{ |scope| scope_with_where?(scope) }
    results = scopes.map do |scope|
      start_time = Time.current
      result = autocomplete_result(scope)
      end_time = Time.current
      puts "#{end_time - start_time} seconds for #{scope[:name]}."
      result
    end
    results = results.flatten
    results.uniq{ |result| [result[:model_name], result[:id]] }
  end

  def autocomplete_result(scope)
    return [] unless member.can_read?(klass)
    self.current_scope = scope
    order = scope[:query_order] || 'created_at DESC'
    query = klass.where(where_query, {search: "%#{params[:term]}%"}).order(order)
    query = query.authorized(member)

    query = query.limit(50)
    search_label = scope[:search_label] || :to_s

    query.map {|record| { columns: get_columns_values(columns, record), model_name: klass.name, id: record.id, label: record.send(search_label), value: record.to_s, scope_description: scope[:description]} }
  end

  def get_columns_values( columns, record )
    column_values = Array.new
    if columns.present?
      columns.each do |column_name|
        column_values.push( format_column_value( record[column_name] ) )
      end
    end

    column_values
  end

  def format_column_value(value)
    if value.blank?
      ''
    elsif value.is_a? Date
      format_date(value)
    else
      value
    end
  end

  def scope_name
    params[:global_search_scope].blank? ? search_scopes.first[:name] : params[:global_search_scope]
  end

  def selected_scope
    search_scopes.detect { |item| item[:name] == scope_name } if search_scopes.any?
  end

  def where_query
    return current_scope[:query_where] if current_scope[:query_where]
    where_items = []

    columns.each do |column|
      if data_type(column) == :text && is_array(column)
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

  private

    def klass
      current_scope[:model]
    end

    def columns
      current_scope[:columns]
    end

    def data_type(column)
      klass.new.has_attribute?(column) ? column_def(column).type : :string
    end

    def is_array(column)
      klass.new.has_attribute?(column) ? column_def(column).array : false
    end

    def column_def(column)
      klass.new.column_for_attribute(column)
    end

    def scope_with_where?(scope)
      scope[:columns].any? || scope[:query_where].present?
    end
end
