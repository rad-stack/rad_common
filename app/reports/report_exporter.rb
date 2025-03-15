class ReportExporter < Exporter
  attr_reader :report

  delegate :headers, to: :report

  def initialize(report:, current_user:, format: DEFAULT_FORMAT)
    @report = report
    super(records: report.records, current_user: current_user, format: format)
  end

  def report_name
    "#{report.title} Export"
  end

  private

    def reset_attributes; end

    def process_records(records)
      records
    end
end
