class SecurityRolesController < ApplicationController
  before_action :set_security_role, only: %i[show edit update destroy]

  def index
    authorize SecurityRole
    @security_roles = policy_scope(SecurityRole.sorted).page(params[:page])
  end

  def show
    set_permissions
  end

  def new
    @security_role = SecurityRole.new
    authorize @security_role

    set_permissions
  end

  def edit
    set_permissions
  end

  def create
    @security_role = SecurityRole.new(permitted_params)
    authorize @security_role

    set_permissions

    if @security_role.save
      redirect_to @security_role, notice: 'Security role was successfully created.'
    else
      render :new
    end
  end

  def update
    set_permissions

    if @security_role.update(permitted_params)
      redirect_to @security_role, notice: 'Security role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    destroyed = @security_role.destroy

    if destroyed
      flash[:notice] = 'Security role was successfully deleted.'
    else
      flash[:error] = @security_role.errors.full_messages.join(', ')
    end

    if (destroyed && (URI(request.referer).path == security_role_path(@security_role))) ||
       (URI(request.referer).path == edit_security_role_path(@security_role))
      redirect_to security_roles_path
    else
      redirect_back(fallback_location: security_roles_path)
    end
  end

  def permission
    authorize SecurityRole

    @permission = RadPermission.new(params[:permission_name])
  end

  private

    def set_security_role
      @security_role = SecurityRole.find(params[:id])
      authorize @security_role
    end

    def set_permissions
      @permission_categories = RadPermission.security_role_categories(@security_role)
    end

    def permitted_params
      params.require(:security_role).permit(%i[name external allow_invite allow_sign_up] +
                                              RadPermission.all.map(&:to_sym))
    end
end
