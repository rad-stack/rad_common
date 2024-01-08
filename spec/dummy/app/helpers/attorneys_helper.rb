module AttorneysHelper
  def attorney_show_data(attorney)
    [:company_name] +
      address_show_data(attorney) +
      %i[phone_number email] +
      [created_by_show_item(attorney)] +
      [:active]
  end

  def attorney_actions(attorney)
    [link_to(icon(:print, 'Printable Version'),
             attorney_path(attorney, format: :pdf),
             target: '_blank',
             class: 'btn btn-info btn-sm',
             rel: 'noopener')]
  end
end
