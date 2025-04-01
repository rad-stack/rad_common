class RadDeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  helper RadCommon::ApplicationHelper

  layout 'rad_mailer'

  before_action :set_defaults

  default reply_to: RadConfig.admin_email!

  def confirmation_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = I18n.t('rad_common.confirmation_instructions', default: 'Here are your confirmation instructions.')

    @email_action = { message: 'You can confirm your account email through this link.',
                      button_text: 'Confirm My Account',
                      button_url: confirmation_url(@resource, confirmation_token: @token) }

    super
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = 'Someone has requested a link to change your password. ' \
               "If you didn't request this, please ignore this email."

    @email_action = { message: "Your password won't change until you click this link and create a new one.",
                      button_text: 'Change My Password',
                      button_url: edit_password_url(@resource, reset_password_token: @token) }

    super
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = 'Your account has been locked due to an excessive number of unsuccessful sign in attempts.'

    @email_action = { message: 'Click the link to unlock your account.',
                      button_text: 'Unlock My Account',
                      button_url: unlock_url(@resource, unlock_token: @token) }

    super
  end

  def invitation_instructions(record, token, opts = {})
    @token = token
    initialize_from_record(record)

    @recipient = @resource
    @message = "Someone has invited you to #{app_name}, you can accept it through the link below. If you don't " \
               "want to accept the invitation, please ignore this email. Your account won't be created until you " \
               'access the link and set your password.'

    @email_action = { message: 'Click the link to accept the invitation.',
                      button_text: 'Accept',
                      button_url: accept_invitation_url(@resource, invitation_token: @token) }

    super
  end

  def email_changed(record, opts = {})
    initialize_from_record(record)

    @recipient = @resource
    @message = "The email address for your #{app_name} account was recently changed. If you made this change, please " \
               "disregard this message. If you didn't make this change, please let us know immediately."

    super
  end

  def password_change(record, opts = {})
    initialize_from_record(record)

    @recipient = @resource
    @message = "The password for your #{app_name} account was recently changed. If you made this change, you don't " \
               "need to do anything more. If you didn't make this change, please let us know, and reset your " \
               'password immediately.'

    super
  end

  def default_url_options
    if @resource.portal?
      { host: RadConfig.portal_host_name!(@resource) }
    else
      { host: RadConfig.host_name! }
    end
  end

  private

    def set_defaults
      @include_yield = false
    end

    def app_name
      @resource.portal? ? RadConfig.portal_app_name!(@resource) : RadConfig.app_name!
    end
end
