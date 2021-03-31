module Api
  class BasicAppController < ActionController::Base
    # TODO: is this the best way?
    protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? }

    before_action :auth_with_ip_address
    before_action :auth_with_basic

    protected

      def auth_with_ip_address
        return # TODO: bypassng for now
        return if ENV.fetch('STAGING') == 'true'

        ip_address = request.remote_ip
        unless ENV.fetch('BASIC_APP_IP_RANGES').split(',').include?(ip_address)
          raise "unauthorized IP address: #{ip_address}"
        end
      end

      def auth_with_basic
        authenticate_or_request_with_http_basic do |username, password|
          username == ENV.fetch('BASIC_APP_USER') && password == ENV.fetch('BASIC_APP_PASSWORD')
        end
      end

      def reply_success
        render json: nil, status: :ok
      end
  end
end
