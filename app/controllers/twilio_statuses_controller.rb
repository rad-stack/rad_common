class TwilioStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :set_twilio_log

  def create
    skip_authorization
    return if @twilio_log.blank?

    @twilio_log.update! twilio_status: params['MessageStatus']
  end

  private

    def set_twilio_log
      @twilio_log = TwilioLog.find_by(message_sid: params['MessageSid'])
    end
end
