class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    skip_authorization

    redirect_to new_user_session_path unless user_signed_in?
  end
end
