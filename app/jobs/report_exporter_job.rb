class ReportExporterJob < BaseExporterJob
  private

    def exporter
      @exporter ||= export_class.new(report: report, current_user: user, format: format)
    end

    def report
      @report ||= report_class.new(user, nil, params)
    end

    def report_name
      exporter.report_name
    end
end
