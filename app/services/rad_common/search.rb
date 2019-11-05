module RadCommon
  class Search
    include RadCommon::Filtering
    include RadCommon::Sorting
    attr_reader :params, :current_user

    def initialize(query:, filters:, sort_columns:[], current_user:, params:)
      @results = query
      @current_user = current_user
      @params = params
      setup_filtering(filters: filters)
      setup_sorting(sort_columns: sort_columns)
    end

    def results
      retrieve_results
    end

    def retrieve_results
      apply_filtering
      apply_sorting
      @results
    end

    private

    def search_params?
      params.has_key? :search
    end
  end
end