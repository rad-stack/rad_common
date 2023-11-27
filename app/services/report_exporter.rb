class ReportExporter < Exporter
  attr_reader :report

  def initialize(report:, current_user:, format: DEFAULT_FORMAT)
    @report = report
    super(records: report.records, current_user: current_user, format: format)
  end

  def report_name
    "#{report.title} Export"
  end

  private

    def reset_attributes; end
end
