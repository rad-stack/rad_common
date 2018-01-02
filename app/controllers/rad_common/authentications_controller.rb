module RadCommon
  class AuthenticationsController < ApplicationController
    before_action :set_existing_user

    def create
      provider = params[:provider]

      @user, message = RadbearRails.send(provider.to_sym, request.env["omniauth.auth"], current_user)
      handle_user(provider.titlecase, message)
    end

    private

      def set_existing_user
        @existing_user = user_signed_in? && current_user
      end

      def handle_user(kind, message)
        if @existing_user
          if @user
            flash[:success] = "Successfully connected with #{kind}#{message}"
          else
            flash[:error] = "Could not connect with #{kind}#{message}"
          end

          if !request.env["HTTP_REFERER"].blank?
            redirect_back(fallback_location: root_path)
          else
            redirect_to root_path
          end
        else
          if @user && @user.persisted?
            success = "Successfully authenticated from #{kind} account. "
            flash[:notice] = "#{success} #{message}"
            sign_in_and_redirect @user, event: :authentication #todo what is :event for?
          else
            flash[:error] = message
            if !request.env["HTTP_REFERER"].blank?
              redirect_back(fallback_location: root_path)
            else
              redirect_to root_path
            end
          end
        end
      end

  end
end
