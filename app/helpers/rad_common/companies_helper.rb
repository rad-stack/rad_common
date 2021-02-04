module RadCommon
  module CompaniesHelper
    def company_show_data(company)
      [{ label: 'Address', value: company.full_address },
       { label: 'Phone Number', value: (link_to company.phone_number, "tel:#{company.phone_number}") },
       { label: 'Website', value: (link_to company.website, company.website, target: :_blank, rel: :noopener) },
       { label: 'Email', value: (mail_to company.email) },
       :timezone,
       :validity_checked_at]
    end
  end
end
