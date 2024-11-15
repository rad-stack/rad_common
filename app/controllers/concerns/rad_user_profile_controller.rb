module RadUserProfileController
  extend ActiveSupport::Concern

  included do
    before_action :set_user, only: %i[show edit update]
    before_action :set_onboarded_initial, only: :update
  end

  def show
    @onboarding = Onboarding.new(current_user)
  end

  def edit; end

  def update
    @user.profile_entered = true

    if @user.update(permitted_params)
      return redirect_to Onboarding.new(@user).onboarded_path, notice: 'Onboarding completed' if just_onboarded?

      redirect_to user_profile_path(@user), notice: 'Your profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  protected

    def just_onboarded?
      !@onboarded_initial && Onboarding.new(@user).onboarded?
    end

    def set_onboarded_initial
      @onboarded_initial = Onboarding.new(@user).onboarded?
    end

    def set_user
      @user = User.find(params[:id])
      authorize @user, policy_class: UserProfilePolicy
    end

    def update_redirect
      redirect_to user_profile_path(@user), notice: 'Your profile was successfully updated.'
    end

    def base_params
      []
    end

    def permitted_params
      params.require(:user).permit(base_params + RadConfig.additional_user_profile_params!)
    end
end
