class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :check_tenant

  def global_search
    # authorization is checked within the global_autocomplete_result
    render json: global_autocomplete_result
  end

  def global_search_result
    # authorization is checked by the redirect destination

    if params[:global_search_model_name].blank? || params[:global_search_id].blank?
      flash[:error] = 'Missing parameters'
      redirect_to root_path
    else
      model_name = params[:global_search_model_name]
      the_id = params[:global_search_id]
      klass = Object.const_get model_name
      the_object = klass.find_by(id: the_id)

      if params[:global_search_scope].present?
        current_member.update_column(:global_search_default, params[:global_search_scope])
      end

      if the_object
        redirect_to the_object
      else
        flash[:error] = 'Could not find record, please try your search again.'
        redirect_to root_path
      end
    end
  end

  private

    def global_autocomplete_result
      search_scopes = view_context.global_search_scopes
      return [] if search_scopes.empty?

      results = []

      search_scopes.each do |scope|
        #scope_name = params[:global_search_scope].blank? ? search_scopes.first[:name] : params[:global_search_scope]
        #scope = search_scopes.select {|item| item[:name] == scope_name }.first
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
        query = query.authorized(current_member)

        query = query.limit(50)

        if current_member.can_read?(klass)
          search_label = scope[:search_label] || :to_s
          results += query.map {|record| { columns: get_columns_values(columns, record), model_name: klass.name, id: record.id, label: record.send(search_label), value: record.to_s} }
        end
      end

      results
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
