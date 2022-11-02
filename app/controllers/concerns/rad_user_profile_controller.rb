module RadUserProfileController
  extend ActiveSupport::Concern

  included do
    before_action :set_user, only: %i[show edit update]
    before_action :set_onboarded, only: :update
  end

  def show
    @onboarding = Onboarding.new(current_user)
  end

  def edit; end

  def update
    @user.profile_entered = true

    if @user.update(permitted_params)
      update_redirect
    else
      render :edit
    end
  end

  protected

    def set_user
      @user = User.find(params[:id])
      authorize @user, policy_class: UserProfilePolicy
    end

    def update_redirect
      redirect_to user_profile_path(@user), notice: 'Your profile was successfully updated.'
    end
end
