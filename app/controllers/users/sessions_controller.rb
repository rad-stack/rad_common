module Users
  class SessionsController < Devise::SessionsController
    def create
      user_params = params.require(:user).permit(:email, :password, :remember_me)
      user = User.find_for_database_authentication(email: user_params[:email])

      if user&.valid_password?(user_params[:password])
        if user.otp_required_for_login?
          session[:otp_user_id] = user.id
          redirect_to users_two_factor_auth_path
        else
          # set_flash_message!(:notice, :signed_in)
          sign_in(:user, user)
          respond_with user, location: after_sign_in_path_for(user)
        end
      else
        self.resource = User.new(email: user_params[:email])
        flash.now[:alert] = I18n.t('devise.failure.invalid', authentication_keys: 'Email')
        render :new, status: :unprocessable_entity
      end
    end
  end
end
