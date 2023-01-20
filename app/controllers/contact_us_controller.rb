class ContactUsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_company

  def new; end

  def create
    RadbearMailer.simple_message(@company.email,
                                 "Contact Request from #{RadicalConfig.app_name!}",
                                 message_body).deliver_later

    redirect_to redirect_when_sent, notice: 'Your message was successfully sent.'
  end

  private

    def redirect_when_sent
      user_signed_in? ? root_path : new_contact_us_path
    end

    def message_body
      "Contact request from #{email}, subject: #{subject}, message: #{message}"
    end

    def email
      return current_user.email if user_signed_in?
      raise 'missing email' if params[:contact_us][:your_email_address].blank?

      params[:contact_us][:your_email_address]
    end

    def subject
      raise 'missing subject' if params[:contact_us][:subject].blank?

      params[:contact_us][:subject]
    end

    def message
      raise 'missing message' if params[:contact_us][:message].blank?

      params[:contact_us][:message]
    end

    def set_company
      skip_authorization
      @company = Company.main
    end
end
