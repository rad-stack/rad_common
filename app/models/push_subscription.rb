require 'web_push'

class PushSubscription < ApplicationRecord
  belongs_to :user

  GONE_STATUSES = [404, 410].freeze
  RETRY_STATUSES = [429, 500, 502, 503].freeze

  validates :endpoint, presence: true, uniqueness: true
  validates :p256dh, presence: true
  validates :auth, presence: true

  def push_message(title:, body:, url: nil, tag: nil)
    payload = { title: title, body: body, url: url, tag: tag }.compact.to_json

    WebPush.payload_send(
      message: payload,
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
      vapid: vapid_credentials,
      ttl: 1.hour.to_i
    )

    true
  rescue WebPush::InvalidSubscription, WebPush::ExpiredSubscription => e
    Rails.logger.info("[WebPush] Removing invalid subscription #{id}: #{e.message}")
    destroy
    false
  rescue WebPush::ResponseError => e
    handle_push_response_error(e)
  rescue WebPush::Error, Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED => e
    Rails.logger.error("[WebPush] Delivery failed for subscription #{id}: #{e.message}")
    raise
  end

  private

    def handle_push_response_error(error)
      status = error.response&.code.to_i

      if GONE_STATUSES.include?(status)
        Rails.logger.info("[WebPush] Subscription #{id} gone (#{status}), removing")
        destroy
        false
      elsif RETRY_STATUSES.include?(status)
        Rails.logger.warn("[WebPush] Subscription #{id} got #{status}, will retry")
        raise
      else
        Rails.logger.error("[WebPush] Unexpected status #{status} for subscription #{id}")
        Sentry.capture_exception(error) if defined?(Sentry)
        false
      end
    end

    def vapid_credentials
      {
        subject: RadConfig.vapid_subject!,
        public_key: RadConfig.vapid_public_key!,
        private_key: RadConfig.vapid_private_key!
      }
    end
end
