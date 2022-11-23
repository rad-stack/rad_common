class TwilioStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_twilio_log

  def create
    skip_authorization
    return if @twilio_log.blank? # TODO: log this or just ignore?

    puts "Twilio Status for #{@twilio_log.message_sid}: #{params['MessageStatus']}"
  end

  private

    def set_twilio_log
      @twilio_log = TwilioLog.find_by(message_sid: params['MessageSid'])
    end
end
