class UserPreferencesController < ApplicationController
  skip_after_action :verify_authorized

  def update_sidebar
    session[:sidebar_collapsed] = params[:collapsed] == true || params[:collapsed] == 'true'
    head :ok
  end
end
