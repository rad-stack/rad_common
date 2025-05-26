class UsersController < ApplicationController
  include Exportable

  before_action :set_user, only: %i[show edit update destroy resend_invitation confirm test_email test_sms reactivate
                                    update_timezone ignore_timezone]

  before_action :remove_blank_passwords, only: :update

  def index
    authorize User

    if RadConfig.pending_users? && policy(User.new).update?
      @pending = policy_scope(User).includes(:user_status, :security_roles)
                                   .pending
                                   .recent_first
                                   .page(params[:pending_page]).per(3)
    end

    @user_search = UserSearch.new(params, current_user)
    @users = policy_scope(@user_search.results).page(params[:page])
  end

  def show
    @permission_categories = RadPermission.user_categories(@user)
    return unless RadConfig.user_clients?

    @user_clients = @user.user_clients.sorted
  end

  def new
    @user = User.new(timezone: Company.main.timezone)
    authorize @user
  end

  def edit; end

  def create
    @user = User.new
    @user.assign_attributes permitted_attributes(@user)

    if policy(@user).update_security_roles? && !params[:user][:security_roles].nil?
      @user.security_roles = SecurityRole.resolve_roles(params[:user][:security_roles])
    end

    authorize @user

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @user.assign_attributes permitted_attributes(@user)
      @user.approved_by = true_user

      if policy(@user).update_security_roles? && !params[:user][:security_roles].nil?
        @user.security_roles = SecurityRole.resolve_roles(params[:user][:security_roles])
      end

      authorize @user

      if @user.save
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    destroyed = false

    if @user == current_user
      flash[:error] = "Can't delete yourself."
      redirect_back(fallback_location: users_path)
      return
    end

    if @user.other_audits_created.count.positive?
      flash[:error] = "User has audit history, can't delete"
      redirect_back(fallback_location: users_path)
      return
    elsif @user.audits_created.count.positive?
      @user.audits_created.delete_all
    end

    duplicates = if duplicates_enabled?
                   @user.duplicates
                 else
                   []
                 end

    if @user.destroy
      flash[:notice] = 'User deleted.'
      destroyed = true
    else
      flash[:error] = @user.errors.full_messages.join(', ')
    end

    if destroyed
      duplicates.each do |item|
        item[:record].process_duplicates
      end
    end

    if (destroyed && (URI(request.referer).path == user_path(@user))) ||
       (URI(request.referer).path == edit_user_path(@user))
      redirect_to users_path
    else
      redirect_back(fallback_location: users_path)
    end
  end

  def resend_invitation
    @user.invite!(current_user)
    redirect_back fallback_location: root_path, notice: 'We resent the invitation to the user.'
  end

  def confirm
    @user.confirm
    redirect_to @user, notice: 'User was successfully confirmed.'
  end

  def test_email
    @user.test_email! current_user
    redirect_to @user, notice: 'A test email was sent to the user.'
  end

  def test_sms
    @user.test_sms! current_user
    redirect_to @user, notice: 'A test SMS was sent to the user.'
  end

  def reactivate
    if @user.reactivate
      flash[:notice] = 'User was successfully reactivated.'
    else
      flash[:error] = "User could not be reactivated: #{@user.errors.full_messages.to_sentence}"
    end

    redirect_to @user
  end

  def update_timezone
    UserTimezone.new(@user).update!
    redirect_back fallback_location: @user, notice: 'User was successfully updated.'
  end

  def ignore_timezone
    UserTimezone.new(@user).ignore!
    redirect_back fallback_location: @user, notice: 'User was successfully updated.'
  end

  private

    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    def remove_blank_passwords
      return unless params[:user][:password].blank? && params[:user][:password_confirmation].blank?

      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    def duplicates_enabled?
      RadCommon::AppInfo.new.duplicates_enabled?('User')
    end
end
