class SendgridStatusesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  before_action :check_multiple_emails

  def create
    skip_authorization
    Notifications::SendgridEmailStatusNotification.main.notify! payload
    head :ok
  end

  private

    def check_multiple_emails
      return if params['_json'].pluck(:email).uniq.size == 1

      raise "multiple emails detected: #{payload}"
    end

    def payload
      params['_json'].map do |item|
        { email: item['email'],
          event: item['event'],
          type: item['type'],
          bounce_classification: item['bounce_classification'],
          reason: item['reason'] }
      end
    end
end
