class SecurityGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_tenant
  before_action :set_security_group, only: %i[show audit]

  authorize_actions_for SecurityGroup
  authority_actions audit: 'audit'

  def index
    @security_groups = SecurityGroup.by_name
  end

  def show; end

  private
    def set_security_group
      @security_group = SecurityGroup.find(params[:id])
    end

end
