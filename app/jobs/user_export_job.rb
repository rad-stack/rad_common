class UserExportJob < ExporterJob
  def export_class
    UserExport
  end

  def search_class
    UserSearch
  end

  def report_name
    'User Export'
  end
end
