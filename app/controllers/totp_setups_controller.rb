class TotpSetupsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_two_factor_auth

  def show
    authorize :totp_setup
  end

  def new
    authorize :totp_setup

    factor = TwilioVerifyService.setup_totp_service(current_user)
    session[:totp_qr_code_uri] = factor.binding['uri']

    @qr_code_uri = session[:totp_qr_code_uri]
  end

  def create
    authorize :totp_setup

    unless current_user.twilio_totp_factor_sid.present? && session[:totp_qr_code_uri].present?
      redirect_to totp_setup_path, alert: 'Please start the setup process first.'
      return
    end

    result = TwilioVerifyService.register_totp_service(current_user, params[:code])

    if result.status == 'verified'
      session.delete(:totp_qr_code_uri)
      redirect_to totp_setup_path, notice: 'Authenticator app has been set up successfully.'
    else
      @qr_code_uri = session[:totp_qr_code_uri]
      flash.now[:alert] = 'Invalid code. Please try again.'
      render :new
    end
  end

  def destroy
    authorize :totp_setup

    if current_user.twilio_totp_factor_sid.present?
      begin
        TwilioVerifyService.delete_totp_factor(current_user)
      rescue Twilio::REST::RestError
        # Factor may already be deleted on Twilio's side
      end
      current_user.update(twilio_totp_factor_sid: nil)
    end

    session.delete(:totp_qr_code_uri)
    redirect_to totp_setup_path, notice: 'Authenticator app has been disabled.'
  end

  private

    def require_two_factor_auth
      return if current_user.otp_required_for_login?

      redirect_to root_path, alert: 'Two-factor authentication is not enabled for your account.'
    end
end
