module RadCommon
  class SendgridController < ApplicationController
    skip_before_action :authenticate_user!

    def email_error
      skip_authorization

      emails = []

      params[:_json].each do |param|
        emails << param[:email]
      end

      email = emails.first
      admins = User.admins

      subject = 'Invalid Email'
      message = "Someone tried to send an email to #{email} and the email was not properly sent."
      recipients = admins.map(&:email)

      recipients.each do |recipient|
        RadbearMailer.simple_message(recipient, subject, message).deliver_later
      end
    end
  end
end
