module DeviseAuthy
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        before_action :check_request_and_redirect_to_verify_token, :if => :is_signing_in?
      end

      private

      def remember_device(id)
        cookies.signed[:remember_device] = {
          :value => {expires: Time.now.to_i, id: id}.to_json,
          :secure => !(Rails.env.test? || Rails.env.development?),
          :httponly => !(Rails.env.test? || Rails.env.development?),
          :expires => resource_class.authy_remember_device.from_now
        }
      end

      def forget_device
        cookies.delete :remember_device
      end

      def require_token?
        id = warden.session(resource_name)[:id]
        cookie = cookies.signed[:remember_device]
        return true if cookie.blank?

        # require token for old cookies which just have expiration time and no id
        return true if cookie.to_s =~ %r{\A\d+\z}

        cookie = JSON.parse(cookie) rescue ""
        return cookie.blank? || (Time.now.to_i - cookie['expires'].to_i) > \
               resource_class.authy_remember_device.to_i || cookie['id'] != id
      end

      def is_devise_sessions_controller?
        self.class == Devise::SessionsController || self.class.ancestors.include?(Devise::SessionsController)
      end

      def is_signing_in?
        if devise_controller? &&
          is_devise_sessions_controller? &&
          self.action_name == "create"
          return true
        end

        return false
      end

      def check_request_and_redirect_to_verify_token
        if signed_in?(resource_name) &&
           warden.session(resource_name)[:with_authy_authentication] &&
           require_token?
          # login with 2fa
          id = warden.session(resource_name)[:id]

          remember_me = (params.fetch(resource_name, {})[:remember_me].to_s == "1")
          return_to = session["#{resource_name}_return_to"]
          sign_out

          session["#{resource_name}_id"] = id
          # this is safe to put in the session because the cookie is signed
          session["#{resource_name}_password_checked"] = true
          session["#{resource_name}_remember_me"] = remember_me
          session["#{resource_name}_return_to"] = return_to if return_to

          redirect_to verify_authy_path_for(resource_name)
          return
        end
      end

      def verify_authy_path_for(resource_or_scope = nil)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        send(:"#{scope}_verify_authy_path")
      end

      def send_one_touch_request(authy_id)
        Authy::OneTouch.send_approval_request(id: authy_id, message: I18n.t('request_to_login', scope: 'devise'))
      end

      def record_authy_authentication
        @resource.update_attribute(:last_sign_in_with_authy, DateTime.now)
        session["#{resource_name}_authy_token_checked"] = true
        sign_in(resource_name, @resource)
        set_flash_message(:notice, :signed_in) if is_navigational_format?
      end
    end
  end
end
