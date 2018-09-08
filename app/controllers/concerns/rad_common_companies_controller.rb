module RadCommonCompaniesController
  extend ActiveSupport::Concern

  def global_validity_check
    authorize_action_for @company
    GlobalValidityJob.perform_later(@company, current_user)
    flash[:success] = "We're checking the validity of all of your company's data. You will get an email with the results. This may take a while."
    redirect_to company_path(@company)
  end
end
