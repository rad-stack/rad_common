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

  def csv_report_button(report, report_path)
    return unless report.csv_exportable? && report.valid?

    query_string = report.params.to_unsafe_hash.merge(format: :csv).to_query
    link_to(icon(:file, 'Export to File'), "#{report_path}?#{query_string}", class: 'btn btn-secondary btn-sm')
  end

  def format_report_boolean(value)
    if pdf_output?
      value ? 'Yes' : 'No'
    else
      format_boolean(value)
    end
  end

  def report_popover_content(others)
    items = others.map { |other| "<li>#{other}</li>" }.join(' ')
    "<ul>#{items}</ul>"
  end
end
