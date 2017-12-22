class RadMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  helper RadCommon::SecuredLinkHelper

  layout 'radbear_mailer'
  before_action :set_defaults
  default from: Devise.mailer_sender

  def simple_message(company, recipient, subject, message, options = {})
    @company = company
    @recipient = recipient
    @message = simple_format(message)

    if options[:email_action]
      @email_action = options[:email_action]
    end

    if @recipient.respond_to?(:email)
      to_address = "\"#{@recipient}\" <#{@recipient.email}>"
    elsif @recipient.class == String
      to_address = @recipient
    else
      raise "recipient of type #{@recipient.class} if not valid"
    end

    if options[:from]
      mail(to: to_address, subject: subject, from: options[:from])
    else
      mail(to: to_address, subject: subject)
    end
  end

  def global_validity(company, recipient, problems)
    @company = company
    @recipient = recipient
    @problems = problems

    mail(to: @recipient.email, subject: "Invalid data in #{I18n::t(:app_name)}")
  end

  private

    def set_defaults
      unless File.exist?('app/assets/images/app_logo.png') == File.exist?('public/app_logo.png')
        raise 'This mailer requires app_logo.png to be in both places.'
      end

      @include_yield = true
      @optional = false
    end
end
