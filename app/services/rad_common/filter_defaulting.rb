class FilterDefaulting
  def self.apply_defaults(current_user, search)
    return unless current_user.respond_to?(:filter_defaults)

    if clear_filters?(search.params)
      clear_filter_defaults
    elsif search.search_params?
      update_user_filter_defaults(current_user, search.search_params)
    else
      search.params[:search] = load_filter_defaults(search, current_user)
    end
  end

  class << self
    private

    def clear_filters?(params)
      params.has_key? :clear_filters
    end

    def clear_filter_defaults
      current_filter_defaults = current_user.filter_defaults
      searchable_columns_strings.each { |column| current_filter_defaults[column] = '' }
      current_user.update_column(:filter_defaults, current_filter_defaults)
    end

    def load_filter_defaults(search, current_user)
      return if current_user.filter_defaults.blank?

      defaults = current_user.filter_defaults.slice(*search.searchable_columns_strings)
      return if defaults.blank?

      current_user.filter_defaults.slice(*search.searchable_columns_strings)
    end

    def update_user_filter_defaults(current_user, search_params)
      filter_defaults = current_user.filter_defaults
      filter_defaults = {} if filter_defaults.blank?
      search_params.each do |filter_name, value|
        filter_defaults[filter_name.to_s] = value
      end
      current_user.update_column(:filter_defaults, filter_defaults)
    end
  end
end