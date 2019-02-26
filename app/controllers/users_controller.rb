class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy audit audit_by]

  authorize_actions_for User
  authority_actions audit: 'audit', audit_by: 'audit', audit_search: 'audit'

  def index
    @pending = User.pending.by_name

    @status = if params[:status].present?
                if params[:status] == 'All'
                  nil
                else
                  UserStatus.find(params[:status])
                end
              else
                UserStatus.default_active_status
              end

    @users = User.recent_first.page(params[:page])
    @users = @users.where(user_status: @status) if @status

    @user_statuses = UserStatus.not_pending.by_id
  end

  def show; end

  def edit; end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user.assign_attributes(permitted_params)
    @user.approved_by = current_user
    @user.security_roles = resolve_roles(params[:user][:security_roles])

    if @user.save
      flash[:success] = 'User updated.'
      redirect_to @user
    else
      flash[:error] = "Unable to update user: #{@user.errors.full_messages.join(',')}"
      render :edit
    end
  end

  def destroy
    if @user == current_user
      flash[:error] = "Can't delete yourself."
    elsif @user.audits_created(nil).any?
      flash[:error] = "User has audit history, can't delete"
    elsif @user.destroy
      flash[:success] = 'User deleted.'
    else
      flash[:error] = @user.errors.full_messages.join(', ')
    end

    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def resolve_roles(role_ids)
      if role_ids
        ids = role_ids.select { |id| id != '' }.map { |id| id.to_i }
        SecurityRole.where(id: ids)
      else
        []
      end
    end

    def permitted_params
      base_params = %i[user_status_id first_name last_name mobile_phone last_activity_at
                       password password_confirmation super_admin external]

      params.require(:user).permit(base_params + Rails.application.config.additional_user_params)
    end
end
