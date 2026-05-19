module Users
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def create
      if existing_open_invitation?
        flash[:error] = 'There is an open invitation for this user, please accept the invitation or ' \
                        'ask the admin to re-invite you.'
        redirect_to root_path
      else
        super
      end
    end

    private

      def existing_open_invitation?
        email = sign_up_params[:email].strip.downcase
        return false if email.blank?

        user = User.find_by(email: email)
        user.present? && user.needs_accept_invite?
      end
  end
end
