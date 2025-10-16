class CustomReportExporterJob < BaseExporterJob
  private

    def exporter
      @exporter ||= CustomReportExporter.new(report: report, current_user: user, format: format)
    end

    def report
      @report ||= RadReports::Report.new(
        custom_report: custom_report,
        current_user: user,
        params: ActionController::Parameters.new(params)
      )
    end

    def custom_report
      @custom_report ||= CustomReport.find(params['custom_report_id'])
    end

    def report_name
      custom_report.name
    end
end
