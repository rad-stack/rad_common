class TwilioStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :set_contact_log

  def create
    skip_authorization

    if @contact_log.present?
      @contact_log.contact_log_recipients.each do |recipient|
        recipient.update! sms_status: params['MessageStatus']
      end
    end

    head :ok
  end

  private

    def set_contact_log
      @contact_log = ContactLog.sms.find_by(sms_message_id: params['MessageSid'])
    end
end
