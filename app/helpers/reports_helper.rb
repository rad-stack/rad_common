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

  def format_report_boolean(value)
    if pdf_report?
      value ? 'Yes' : 'No'
    else
      format_boolean(value)
    end
  end

  def pdf_report?
    request.format.pdf?
  end

  def report_popover_content(others)
    items = others.map { |other| "<li>#{other}</li>" }.join(' ')
    "<ul>#{items}</ul>"
  end
end
