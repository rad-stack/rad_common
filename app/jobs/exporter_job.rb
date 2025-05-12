class ExporterJob < BaseExporterJob
  private

    def exporter
      @exporter ||= export_class.new(records: records, current_user: user, format: format)
    end

    def records
      @records ||= search_class.new(search_params, user).results
    end

    def search_params
      @search_params ||= params.include?('search') ? ActionController::Parameters.new(search: params['search']) : {}
    end
end
