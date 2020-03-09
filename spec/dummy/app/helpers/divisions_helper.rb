module DivisionsHelper
  def division_show_data(division)
    [:name, :code, :notify, :timezone, :hourly_rate, :additional_info,
     { label: 'Status', value: enum_to_translated_option(Division, :division_status, division.division_status) },
     { label: 'Logo', value: render('layouts/attachment', record: division, attachment_name: 'logo', new_tab: true) },
     { label: 'Icon', value: render('layouts/attachment', record: division, attachment_name: 'icon', new_tab: true) },
     { label: 'Avatar', value: render('layouts/attachment', record: division, attachment_name: 'avatar', new_tab: true) },
     { label: 'Attachment', value: render('layouts/attachment', record: division, attachment_name: 'attachment', new_tab: true) },
     { label: 'Owner', value: secured_link(division.owner) }]
  end
end
