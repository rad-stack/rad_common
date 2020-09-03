class UserSecurityRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_security_role, only: %i[show]

  def show
    redirect_to @user_security_role.user
  end

  private

    def set_user_security_role
      @user_security_role = UserSecurityRole.find(params[:id])
      authorize @user_security_role.security_role
    end
end
