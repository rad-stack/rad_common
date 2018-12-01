class RadbearMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include RadCommon::ApplicationHelper
  helper RadCommon::SecuredLinkHelper

  layout 'radbear_mailer'
  before_action :set_defaults

  default from: Devise.mailer_sender
  default reply_to: Rails.application.config.app_admin_email

  def new_user_signed_up(admin, user)
    auto_approve = user.auto_approve?

    action_message = 'Review their user registration information'
    action_message += auto_approve ? ' if desired.' : ' and approve them if desired.'

    @email_action = { message: action_message,
                      button_text: auto_approve ? 'Review' : 'Review & Approve',
                      button_url: edit_user_url(user) }

    @recipient = admin
    @message = "#{user} has signed up on #{I18n.t(:app_name)}"
    @message += auto_approve ? '.' : ' and is awaiting approval.'
    mail(to: "\"#{admin}\" <#{admin.email}>", subject: "New User on #{I18n.t(:app_name)}")
  end

  def your_account_approved(user)
    @email_action = { button_text: 'Get Started',
                      button_url: root_url }

    @recipient = user
    @message = "Your account was approved and you can begin using #{I18n.t(:app_name)}."
    mail(to: "\"#{user}\" <#{user.email}>", subject: 'Your Account Was Approved')
  end

  def user_was_approved(admin, user, approver)
    @email_action = { message: 'You can review this approval if desired.',
                      button_text: 'Review User',
                      button_url: user_url(user) }

    approved_by_name = (approver ? approver.to_s : 'an admin')

    @recipient = admin
    @message = "#{user} was approved by #{approved_by_name} on #{I18n.t(:app_name)}."
    mail(to: "\"#{admin}\" <#{admin.email}>", subject: "User Was Approved on #{I18n.t(:app_name)}")
  end

  def simple_message(recipient, subject, message, options = {})
    @recipient = recipient
    @message = simple_format(message)
    @email_action = options[:email_action] if options[:email_action]

    if @recipient.respond_to?(:email)
      to_address = "\"#{@recipient}\" <#{@recipient.email}>"
    elsif @recipient.class == String
      to_address = @recipient
    else
      raise "recipient of type #{@recipient.class} if not valid"
    end

    mail(to: to_address, subject: subject)
  end

  def global_validity(recipient, problems)
    @recipient = recipient.count == 1 ? recipient.first : recipient
    @problems = problems

    mail(to: recipient.pluck(:email), subject: "Invalid data in #{I18n.t(:app_name)}")
  end

  def email_report(user, csv, report_name, options = {})
    start_date = options[:start_date]
    end_date   = options[:end_date]

    message_date_string = ''
    message_date_string += " for #{format_datetime(start_date, include_zone: true)}" if start_date.present?
    message_date_string += " to #{format_datetime(end_date, include_zone: true)}" if end_date.present?

    attachment_date_string = ''
    attachment_date_string += "_#{start_date.strftime('%Y%m%d')}" if start_date.present?
    attachment_date_string += "-#{end_date.strftime('%Y%m%d')}" if end_date.present?

    subject_date_string = ''
    subject_date_string += " for #{start_date.strftime('%m/%d/%Y')}" if start_date.present?
    subject_date_string += " - #{end_date.strftime('%m/%d/%Y')}" if end_date.present?

    @recipient = user
    @message = "Attached is the #{report_name}" + message_date_string + '.'
    attachments["#{report_name}#{attachment_date_string}.csv"] = { mime_type: 'text/csv', content: csv }

    mail(to: "\"#{@recipient.first_name} #{@recipient.last_name}\" <#{@recipient.email}>",
         subject: "#{report_name}#{subject_date_string}")
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
