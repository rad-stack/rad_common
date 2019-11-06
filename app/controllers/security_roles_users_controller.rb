class SecurityRolesUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_security_roles_user, only: %i[show]

  def show
    redirect_to @security_roles_user.user
  end

  private

    def set_security_roles_user
      @security_roles_user = SecurityRolesUser.find(params[:id])
    end
end
