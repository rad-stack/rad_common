class CustomReportExporter < Exporter
  attr_reader :report

  def initialize(report:, current_user:, format: DEFAULT_FORMAT)
    @report = report
    super(records: report.all_results, current_user: current_user, format: format)
  end

  private

    def headers
      report.selected_columns.map do |col_name|
        column_def = report.column_definitions.find { |c| c[:name] == col_name }
        column_def ? column_def[:label] : col_name.to_s.titleize
      end
    end

    def write_attributes
      report.selected_columns.map do |col_name|
        column_def = report.column_definitions.find { |c| c[:name] == col_name }
        RadReports::ValueFormatter.format_record_value(current_record, col_name, column_def)
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
