module RadUserProfileController
  extend ActiveSupport::Concern

  included do
    before_action :set_user, only: %i[edit update]
    before_action :set_onboarded_initial, only: :update
  end

  def edit; end

  def update
    @user.profile_entered = true

    if @user.update(permitted_params)
      return redirect_to Onboarding.new(@user).onboarded_path, notice: 'Onboarding completed' if just_onboarded?

      flash[:notice] = 'Your profile was successfully updated.'

      redirect_to edit_user_profile_path(@user)
    else
      render :edit
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

    def base_params
      []
    end

    def permitted_params
      params.require(:user).permit(base_params + RadConfig.additional_user_profile_params!)
    end
end
