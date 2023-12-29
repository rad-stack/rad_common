class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home contact_us terms privacy]

  def home
    skip_authorization

    if marketing_site?
      @marketing_site = true
      render 'pages/marketing'
    elsif user_signed_in?
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

  private

    def marketing_site?
      return true if RadConfig.force_marketing_site?

      RadConfig.allow_marketing_site? && request.host.start_with?('www.')
    end
end
