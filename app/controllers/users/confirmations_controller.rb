module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super

      raise "There is an open invitation for this user: #{resource.email}" if resource.needs_accept_invite?

      resource.notify_new_user_signed_up if resource.errors.empty?
    end
  end
end
