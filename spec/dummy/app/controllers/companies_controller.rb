class CompaniesController < ApplicationController
  include RadCommonCompaniesController

  before_action :authenticate_user!
  before_action :set_company, only: %i[show global_validity_check]

  authorize_actions_for Company
  authority_actions global_validity_check: 'global_validate'

  def show
  end

  private

    def set_company
      @company = Company.main
    end
end
