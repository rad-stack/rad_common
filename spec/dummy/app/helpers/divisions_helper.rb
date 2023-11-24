module DivisionsHelper
  def division_show_data(division)
    [:name,
     :code,
     :notify,
     :timezone,
     :hourly_rate,
     :additional_info,
     :division_status,
     { label: 'Logo', value: render_one_attachment(record: division, attachment_name: 'logo', new_tab: true) },
     { label: 'Icon', value: render_one_attachment(record: division, attachment_name: 'icon', new_tab: true) },
     { label: 'Owner', value: secured_link(division.owner) },
     :category,
     created_by_show_item(division)]
  end
end
