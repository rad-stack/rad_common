class UserProfilesController < ApplicationController
  include RadUserProfileController

  private

    def permitted_params
      params.require(:user).permit(:birth_date)
    end
end
