class GlobalAutocomplete
  include RadCommon::ApplicationHelper

  attr_reader :params, :search_scopes, :member
  def initialize(params, search_scopes, member)
    @params = params
    @search_scopes = search_scopes
    @member = member
  end

  def global_autocomplete_result
    return [] if search_scopes.empty?

    scope_name = params[:global_search_scope].blank? ? search_scopes.first[:name] : params[:global_search_scope]
    scope = search_scopes.select {|item| item[:name] == scope_name }.first
    columns = scope[:columns]
    klass = scope[:model]

    if scope[:query_where]
      where = scope[:query_where]
    else
      where_items = []

      columns.each do |column|

        has_column = klass.new.has_attribute?(column)
        if has_column
          column_def = klass.new.column_for_attribute(column)
          data_type = column_def.type
          is_array = column_def.array
        else
          data_type = :string
          is_array = false
        end

        if data_type == :text && is_array
          where_items.push("ARRAY_TO_STRING(#{column}, '') LIKE :search")
        elsif data_type == :string || data_type == :text
          where_items.push("#{column} ILIKE :search")
        elsif data_type == :date
          where_items.push("to_char(#{column}, 'FMMM/FMDD/YYYY') LIKE :search")
        else
          where_items.push("CAST(#{column} AS TEXT) LIKE :search")
        end
      end

      where = where_items.join(' OR ')
    end

    order = scope[:query_order] || 'created_at DESC'
    query = klass.where(where, {search: "%#{params[:term]}%"}).order(order)
    query = query.authorized(member)

    query = query.limit(50)

    if member.can_read?(klass)
      search_label = scope[:search_label] || :to_s
      query.map {|record| { columns: get_columns_values(columns, record), model_name: klass.name, id: record.id, label: record.send(search_label), value: record.to_s} }
    else
      []
    end
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
end
