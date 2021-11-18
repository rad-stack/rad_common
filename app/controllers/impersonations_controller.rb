class ImpersonationsController < ApplicationController
  def start
    user = User.find(params[:id])
    authorize user, :impersonate?
    impersonate_user user

    redirect_to root_path
  end

  def stop
    skip_authorization
    stop_impersonating_user

    redirect_to root_path
  end
end
