module RadCommon
  class Search
    attr_reader :filters, :params, :current_user

    def initialize(query:, filters:, current_user:, params:)
      @results = query
      @filters = build_search_filters(filters)
      @filter_scope_values = @filters.map(&:scopes).compact.reduce({}, :merge)
      @filter_hash =  Hash[@filters.collect {|f| [f.searchable_name, f]}]
      @current_user = current_user
      @params = params

      setup_defaults
    end

    def results
      retrieve_results
    end

    def retrieve_results
      apply_joins
      apply_filters
      @results
    end

    def apply_filters
      search_params.each do |key, value|
        filter = @filter_hash[key.to_sym]
        @results = filter.apply_filter(@results, value) || @results
      end
    end

    def apply_joins
      @results = @results.joins(joins)
    end

    def clear_filters?
      params.has_key? :clear_filters
    end

    def search_params?
      params.has_key? :search
    end

    def search_params
      search_params? ? params.require(:search).permit(permitted_searchable_columns) : {}
    end

    def setup_defaults
      return unless current_user.respond_to?(:filter_defaults)

      if clear_filters?
        clear_filter_defaults
      elsif search_params?
        update_user_filter_defaults
      else
        load_filter_defaults
      end
    end

    def clear_filter_defaults
      current_filter_defaults = current_user.filter_defaults
      searchable_columns_strings.each { |column| current_filter_defaults[column] = '' }
      current_user.update_column(:filter_defaults, current_filter_defaults)
    end

    def load_filter_defaults
      return if current_user.filter_defaults.blank?

      @params[:search] = current_user.filter_defaults.slice(*searchable_columns_strings)
    end

    def update_user_filter_defaults
      filter_defaults = current_user.filter_defaults
      filter_defaults = {} if filter_defaults.blank?
      search_params.each do |filter_name, value|
        filter_defaults[filter_name.to_s] = value
      end
      current_user.update_column(:filter_defaults, filter_defaults)
    end

    def searchable_columns_strings
      searchable_columns.map(&:to_s)
    end

    def permitted_searchable_columns
      columns = @filters.sort_by { |f| f.multiple ? 1 : 0 }
      columns.map do |f|
        if f.multiple
          hash = {}
          hash[f.searchable_name] = []
          hash
        else
          f.searchable_name
        end
      end
    end

    def searchable_columns
      filters.map(&:searchable_name)
    end

    def joins
      filters.map(&:joins).compact
    end

    def selected_value(column)
      search_params[column]
    end

    private

    def build_search_filters(filters)
      filters.map { |filter| SearchFilter.new(filter) }
    end
  end
end