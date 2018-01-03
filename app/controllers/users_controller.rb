class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_tenant
  before_action :set_user, only: %i[show edit update destroy audit audit_by]

  authorize_actions_for User
  authority_actions audit: 'audit', audit_by: 'audit', audit_search: 'audit'

  def index
    @pending = User.pending.by_name

    if params[:status]
      if params[:status] == "All"
        @status = nil
      else
        @status = UserStatus.find(params[:status])
      end
    else
      @status = UserStatus.default_active_status
    end

    @users = User.recent_first.page(params[:page])
    @users = @users.where(user_status: @status) if @status

    @user_statuses = UserStatus.not_pending.by_id
  end

  def show; end

  def edit; end

  def update
    @user.assign_attributes(permitted_params)
    @user.approved_by = current_member

    if @user.save
      flash[:success] = 'User updated.'
      redirect_to @user
    else
      flash[:error] = "Unable to update user: #{@user.errors.full_messages.join(',')}"
      render :edit
    end
  end

  def destroy
    unless @user == current_user
      if @user.audits_created(nil).any?
        flash[:error] = "User has audit history, can't delete"
      else
        if @user.destroy
          flash[:success] = 'User deleted.'
        else
          flash[:error] = @user.errors.full_messages.join(", ")
        end
      end
    else
      flash[:error] = "Can't delete yourself."
    end

    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
      @member = @user
    end

    def permitted_params
      params.require(:user).permit(:user_status_id, :security_group_id, :first_name, :last_name, :mobile_phone)
    end

end
