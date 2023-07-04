module ReportsHelper
  def printable_report_button(report, report_path)
    return unless report.printable? && report.valid?

    query_string = report.params.to_unsafe_hash.merge(format: :pdf).to_query
    link_to(
      icon(:print, 'Printable Version'),
      "#{report_path}?#{query_string}",
      target: '_blank',
      class: 'btn btn-info btn-sm',
      rel: 'noopener'
    )
  end

  def pdf_report?
    request.format.pdf?
  end
end
