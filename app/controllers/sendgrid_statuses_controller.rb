class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    skip_authorization

    if valid?
      content.each do |item|
        SendgridStatusReceiverJob.perform_later permitted_params(item)
      end

      head :ok
    else
      render json: { message: 'These are not the droids you are looking for.' }, status: :unprocessable_entity
    end
  end

  private

    def permitted_params(item)
      item.permit(:email, :event, :reason, :host_name, :contact_log_id, :timestamp, :useragent, :url)
    end

    def content
      params['_json']
    end

    def valid?
      content.present?
    end
end
