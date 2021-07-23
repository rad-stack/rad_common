module CompaniesHelper
  def edit_company_title(company)
    safe_join(['Editing Company: ', link_to(company.name.presence || 'Missing', '/rad_common/company')])
  end
end
