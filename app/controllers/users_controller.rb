class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy resend_invitation confirm reset_authy]

  def index
    authorize User

    @pending = policy_scope(User).pending.recent_first.page(params[:pending_page]).per(3)

    @user_search = UserSearch.new(params, current_user)
    @users = policy_scope(@user_search.results)

    respond_to do |format|
      format.html do
        @users = @users.page(params[:page])
      end

      format.csv do
        csv = UsersCSV.generate(@users)
        RadbearMailer.email_report(current_user, csv, 'User Export').deliver_later
        flash[:success] = "Your export file is generating. You'll receive an email when it finishes."
        redirect_back fallback_location: users_path
      end
    end
  end

  def show; end

  def edit; end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    ActiveRecord::Base.transaction do
      @user.assign_attributes(permitted_params)
      @user.approved_by = current_user
      @user.security_roles = SecurityRole.resolve_roles(params[:user][:security_roles])

      authorize @user

      if @user.save
        flash[:success] = 'User updated.'
        redirect_to @user
      else
        flash[:error] = "Unable to update user: #{@user.errors.full_messages.join(',')}"
        render :edit
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    destroyed = false

    if @user == current_user
      flash[:error] = "Can't delete yourself."
    elsif @user.audits_created.count.positive?
      flash[:error] = "User has audit history, can't delete"
    elsif @user.destroy
      flash[:success] = 'User deleted.'
      destroyed = true
    else
      flash[:error] = @user.errors.full_messages.join(', ')
    end

    if destroyed && (URI(request.referer).path == user_path(@user)) ||
       (URI(request.referer).path == edit_user_path(@user))
      redirect_to users_path
    else
      redirect_back(fallback_location: users_path)
    end
  end

  def resend_invitation
    @user.invite!(current_user)
    flash[:success] = 'We resent the invitation to the user.'
    redirect_back(fallback_location: root_path)
  end

  def confirm
    @user.confirm
    flash[:success] = 'User was successfully confirmed.'
    redirect_to @user
  end

  def reset_authy
    @user.reset_authy!
    flash[:success] = 'User was successfully reset.'
    redirect_to @user
  end

  private

    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    def permitted_params
      base_params = %i[user_status_id first_name last_name mobile_phone last_activity_at
                       password password_confirmation external timezone avatar]

      params.require(:user).permit(base_params + RadCommon.additional_user_params)
    end
end
