class CompaniesController < ApplicationController
  include RadCommonCompaniesController

  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update global_validity_check audit]

  authorize_actions_for Company
  authority_actions global_validity_check: 'global_validate', audit: 'audit'

  def show; end

  def edit; end

  def update
    if @company.update(permitted_params)
      redirect_to company_path(@company), notice: 'Settings were successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_company
    @company = Company.main
  end

  def permitted_params
    params.require(:company).permit(:name, :phone_number, :website, :email, :address_1, :address_2, :city, :state,
                                    :zipcode, :validity_checked_at, :valid_user_domains_entry, :timezone)
  end
end
