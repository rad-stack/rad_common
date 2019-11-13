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

    def company_actions
      company = Company.main

      return unless Rails.application.config.global_validity_enable_interactive
      return unless policy(company).global_validate?

      confirm = 'This is an exhaustive effort that could cause performance problems on the database. Are you sure?'
      path = "/rad_common/companies/#{company.id}/global_validity_check"

      [link_to('Global Validity Check', path, class: 'btn btn-secondary btn-sm',
                                              method: :post,
                                              data: { confirm: confirm })]
    end
  end
end
