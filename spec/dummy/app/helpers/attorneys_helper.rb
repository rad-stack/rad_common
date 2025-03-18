module AttorneysHelper
  def attorney_show_data(attorney)
    [:company_name] + address_show_data(attorney) + %i[phone_number email]
  end
end
