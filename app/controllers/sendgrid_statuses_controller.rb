class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    skip_authorization

    if valid?
      content.each do |item|
        SendgridStatusReceiver.new(permitted_params(item)).process!
      end

      head :ok
    else
      render json: { message: 'These are not the droids you are looking for.' }, status: :unprocessable_entity
    end
  end

  private

    def permitted_params(item)
      # legacy support for post_id, remove this eventually, see Task 41177
      item.permit(:email, :event, :record_id, :post_id, :host_name, :timestamp, :useragent, :url)
    end

    def content
      params['_json']
    end

    def valid?
      content.present?
    end
end
