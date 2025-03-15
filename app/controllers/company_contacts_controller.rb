class CompanyContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    skip_authorization
    @company = Company.main
  end
end
