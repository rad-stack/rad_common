module RadCommon
  module CompaniesHelper
    def company_show_data(company)
      address_show_data(company) +
        [{ label: 'Phone Number', value: (link_to company.phone_number, "tel:#{company.phone_number}") },
         { label: 'Website', value: (link_to company.website, company.website, target: :_blank, rel: :noopener) },
         { label: 'Email', value: (mail_to company.email) },
         :timezone,
         :validity_checked_at,
         :address_requests_made]
    end

    def company_fav_icon(company)
      return 'favicon.ico' unless company.fav_icon.attached?

      AttachmentUrlGenerator.permanent_attachment_url(Company.main.fav_icon)
    end

    def company_logo(company)
      return 'app_logo.png' unless company.app_logo.attached?

      url_for(company.app_logo)
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
