class ReportExporterJob < ApplicationJob
  queue_as :default

  def perform(params, user_id, format: Exporter::DEFAULT_FORMAT)
    user = User.find(user_id)
    report = report_class.new(user, nil, params)
    exporter = export_class.new(report: report, current_user: user, format: format)
    export = exporter.generate

    RadMailer.email_report(user, export, exporter.report_name, report_options(params).merge(format: format)).deliver_now
  end

  def report_options(_params)
    {}
  end
end
