module Api
  class BasicAppController < ActionController::Base
    protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? }

    before_action :authorize_with_jwt

    private

      def authorize_with_jwt
        head :forbidden unless valid_token?
      end

      def token
        request.headers['HTTP_AUTHORIZATION']&.gsub('Bearer ', '')
      end

      def valid_token?
        return false if token.blank?

        begin
          RadJwt.new.decode token
          return true
        rescue JWT::DecodeError => e
          Rails.logger.warn "Error decoding the JWT: #{e}"
        end

        false
      end

      def reply_success
        render json: nil, status: :ok
      end
  end
end
