class ClientReportExport < ReportExporter
  private

    def write_attributes
      [current_record.to_s, current_record.active?]
    end
end
