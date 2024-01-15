module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super

      raise "There is an open invitation for this user: #{resource.email}" if resource.needs_accept_invite?

      resource.notify_new_user_signed_up if resource.errors.empty? && !confirming_email_change?
    end

    private

      def confirming_email_change?
        resource.unconfirmed_email_previously_changed?
      end
  end
end
