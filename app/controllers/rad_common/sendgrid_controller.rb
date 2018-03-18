module RadCommon
  class SendgridController < ApplicationController
    def email_error
      emails = []

      params[:_json].each do |param|
        emails << param[:email]
      end

      email = emails.first
      super_admins = User.super_admins

      subject = 'Invalid Email'
      message = "Someone tried to send an email to #{email} and the email was not properly sent."
      company = Company.super_company
      from = 'no-reply@groundswell.online'
      recipients = super_admins.map(&:email)

      recipients.each do |recipient|
        RadbearMailer.simple_message(company, recipient, subject, message, from: from).deliver_later
      end
    end
  end
end
