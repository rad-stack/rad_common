module Users
  class RegistrationsController < DeviseInvitable::RegistrationsController
    def create
      if existing_open_invitation?
        self.resource = resource_class.new(sign_up_params.except(:password, :password_confirmation))
        resource.errors.add(:email, :has_open_invitation,
                            message: 'has a pending invitation — please use your invitation email to set up your account')
        clean_up_passwords resource
        set_minimum_password_length if respond_to?(:set_minimum_password_length, true)
        respond_with resource
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
