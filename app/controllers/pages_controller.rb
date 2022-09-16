class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms]

  def home
    skip_authorization

    if user_signed_in?
      redirect_to RadicalConfig.start_route!
    else
      redirect_to new_user_session_path
    end
  end

  def terms
    skip_authorization
  end

  def terms
    skip_authorization
  end

  def privacy
    skip_authorization
  end
end
