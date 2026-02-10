class CustomReportExporter < Exporter
  attr_reader :report

  def initialize(report:, current_user:, format: DEFAULT_FORMAT)
    @report = report
    super(records: report.results, current_user: current_user, format: format)
  end

  private

    def headers
      report.column_definitions.map do |column_def|
        column_def ? column_def[:label] : column_def[:name].titleize
      end
    end

    def write_attributes
      report.column_definitions.map do |column_def|
        RadReports::ValueFormatter.format_record_value(current_record, column_def)
      end
    end

    def reset_attributes
      # No additional reset needed for custom reports
    end

    def process_records(records)
      records
    end

    def report_name
      report.report_name
    end

    def generate_csv
      CSV.generate do |csv|
        csv << headers
        records.each do |record|
          @current_record = record
          reset_attributes
          csv << write_attributes
        end
      end
    end
end
