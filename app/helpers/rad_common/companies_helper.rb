module RadCommon
  module CompaniesHelper
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
