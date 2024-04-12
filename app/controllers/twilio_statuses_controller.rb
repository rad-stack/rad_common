class TwilioStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :set_twilio_log

  def create
    skip_authorization
    return if @contact_log.blank?

    @contact_log.update! twilio_status: params['MessageStatus']
  end

  private

    def set_contact_log
      @contact_log = ContactLog.find_by(message_sid: params['MessageSid'])
    end
end
