class UserProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit edit_imlc update]

  def show
    @onboarding = Onboarding.new(current_user)
  end

  def edit; end

  def edit_imlc; end

  def update
    @user.profile_entered = true

    if @user.update(permitted_params)
      redirect_to user_profile_path(@user), notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
      authorize @user, policy_class: UserProfilePolicy
    end

    def permitted_params
      params.require(:user).permit(:birth_date)
    end
end
