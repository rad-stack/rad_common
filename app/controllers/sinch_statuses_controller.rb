class SinchStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :set_contact_log

  def create
    skip_authorization

    if @contact_log.present?
      @contact_log.contact_log_recipients.each do |recipient|
        recipient.update! fax_status: params.dig('fax', 'status').downcase.to_sym
      end
    end

    head :ok
  end

  private

    def set_contact_log
      @contact_log = ContactLog.fax.find_by(fax_message_id: params.dig('fax', 'id'))
    end
end
