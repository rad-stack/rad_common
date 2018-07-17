class SecurityRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_security_role, only: %i[show edit update destroy audit]

  authorize_actions_for SecurityRole
  authority_actions audit: 'audit', permission: 'read'

  def index
    @security_roles = SecurityRole.by_name.page(params[:page])
  end

  def show; end

  def new
    @security_role = SecurityRole.new
  end

  def edit; end

  def create
    @security_role = SecurityRole.new(permitted_params)

    if @security_role.save
      redirect_to @security_role, notice: 'Security role was successfully created.'
    else
      render :new
    end
  end

  def update
    if @security_role.update(permitted_params)
      redirect_to @security_role, notice: 'Security role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @security_role.destroy

    if destroyed
      flash[:success] = 'Security role was successfully destroyed.'
    else
      flash[:error] = @security_role.errors.full_messages.join(', ')
    end

    if destroyed && (URI(request.referer).path == security_role_path(@security_role)) || (URI(request.referer).path == edit_security_role_path(@security_role))
      redirect_to security_roles_path
    else
      redirect_back(fallback_location: security_roles_path)
    end
  end

  def permission
    @permission_name = params[:permission_name]
    @security_roles = SecurityRole.where("#{@permission_name} = TRUE").by_name
    @users = User.by_permission(@permission_name).by_name
  end

  private

    def set_security_role
      @security_role = SecurityRole.find(params[:id])
    end

    def permitted_params
      params.require(:security_role).permit([:name] + SecurityRole.permission_fields.map { |item| item.to_sym })
    end
end
