class GlobalAutocomplete
  include RadCommon::ApplicationHelper

  attr_reader :params, :search_scopes, :member
  def initialize(params, search_scopes, member)
    @params = params
    @search_scopes = search_scopes
    @member = member
  end

  def global_autocomplete_result
    return [] if search_scopes.empty? || !member.can_read?(scope[:model])
    order = scope[:query_order] || 'created_at DESC'
    query = klass.where(where_query, {search: "%#{params[:term]}%"}).order(order)
    query = query.authorized(member)

    query = query.limit(50)
    search_label = scope[:search_label] || :to_s
    query.map {|record| { columns: get_columns_values(columns, record), model_name: klass.name, id: record.id, label: record.send(search_label), value: record.to_s} }
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

  def scope
    search_scopes.detect { |item| item[:name] == scope_name } if search_scopes.any?
  end

  def where_query
    return scope[:query_where] if scope[:query_where]
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
      scope[:model]
    end

    def columns
      scope[:columns]
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
end
