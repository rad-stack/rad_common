module RadCommon
  module CompaniesHelper
    def company_show_data(company)
      [{ label: 'Address', value: company.full_address },
       { label: 'Phone Number', value: (link_to company.phone_number, "tel:#{company.phone_number}") },
       { label: 'Website', value: (link_to company.website, company.website, target: :_blank) },
       { label: 'Email', value: (mail_to company.email) },
       :timezone,
       :validity_checked_at]
    end

    def company_actions
      return unless Rails.application.config.global_validity_enable_interactive
      return unless current_user.can_global_validate?(@company)

      confirm = 'This is an exhaustive effort that could cause performance problems on the database. Are you sure?'
      path = "/rad_common/companies/#{Company.main.id}/global_validity_check"

      [link_to('Global Validity Check', path, class: 'btn btn-secondary btn-sm',
                                              method: :post,
                                              data: { confirm: confirm })]
    end
  end
end
