class ContactUsController < ApplicationController
  def show
    skip_authorization
    @company = Company.main
  end
end
