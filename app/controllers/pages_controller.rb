class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy]

  def home
    skip_authorization

    if user_signed_in?
      redirect_to RadConfig.start_route!
    else
      redirect_to new_user_session_path
    end
  end

  def contact_us
    skip_authorization
    @company = Company.main
  end

  def terms
    skip_authorization
  end

  def privacy
    skip_authorization
  end
end
