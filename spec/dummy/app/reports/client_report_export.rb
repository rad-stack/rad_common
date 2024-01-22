class ClientReportExport < ReportExporter
  private

    def write_attributes
      [current_record.to_s, format_boolean(current_record.active?)]
    end
end
