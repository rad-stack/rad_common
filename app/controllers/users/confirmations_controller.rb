module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      super
      resource.notify_new_user_signed_up if resource.errors.empty?
    end
  end
end
