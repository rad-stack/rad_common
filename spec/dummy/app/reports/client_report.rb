class ClientReport < BaseReport
  def records
    Client.sorted
  end

  def title
    'Client Report'
  end

  def export_job
    ClientReportExportJob
  end

  def headers
    %w[Name Active]
  end

  def printable?
    true
  end
end
