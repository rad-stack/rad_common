class RadMailer < ActionMailer::Base
  helper RadCommon::SecuredLinkHelper

  layout 'radbear_mailer'
  before_action :set_defaults
  default from: Devise.mailer_sender

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
