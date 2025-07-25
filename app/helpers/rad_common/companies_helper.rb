module RadCommon
  module CompaniesHelper
    def company_show_data(company)
      items = address_show_data(company)

      items += [{ label: 'Phone Number', value: (link_to company.phone_number, "tel:#{company.phone_number}") },
                { label: 'Website',
                  value: (link_to company.website, company.website, target: :_blank, rel: :noopener) },
                { label: 'Email', value: (mail_to company.email) },
                :timezone,
                :validity_checked_at,
                :address_requests_made]

      if company.app_logo.attached?
        items.push(label: 'Logo',
                   value: render_one_attachment(record: company, attachment_name: 'app_logo', new_tab: true))
      end

      if company.fav_icon.attached?
        items.push(label: 'Favicon',
                   value: render_one_attachment(record: company, attachment_name: 'fav_icon', new_tab: true))
      end

      items
    end

    def company_fav_icon(company)
      return 'favicon.ico' unless company.fav_icon.attached?

      AttachmentUrlGenerator.permanent_attachment_url(Company.main.fav_icon)
    end

    def company_logo(company)
      return 'app_logo.png' unless company.app_logo.attached?

      AttachmentUrlGenerator.permanent_attachment_url(company.app_logo)
    end

    def edit_company_title(company)
      safe_join(['Editing Company: ', link_to(company.name.presence || 'Missing', company_path)])
    end

    def company_contact_show_data(company)
      [{ label: 'Address', value: company.full_address },
       { label: 'Phone Number', value: (link_to company.phone_number, "tel:#{company.phone_number}") },
       { label: 'Website', value: (link_to company.website, company.website, target: :_blank, rel: :noopener) },
       { label: 'Email', value: (mail_to company.email) },
       :timezone]
    end
  end
end
