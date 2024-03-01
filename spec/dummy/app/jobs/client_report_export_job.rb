class ClientReportExportJob < ReportExporterJob
  def export_class
    ClientReportExport
  end

  def report_class
    ClientReport
  end
end
