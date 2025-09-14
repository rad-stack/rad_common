class UserTimezone
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def needs_js_timezone?
    user.detected_timezone.present? && user.detected_timezone_js != user.detected_timezone &&
      (user.ignored_timezone.blank? || user.ignored_timezone != user.detected_timezone)
  end

  def set_js_timezone!(timezone)
    return if timezone == user.detected_timezone_js

    user.update! detected_timezone_js: convert_timezone(timezone).name
  end

  def wrong_timezone?
    return false if user.timezone.blank? || user.detected_timezone.blank? || user.detected_timezone_js.blank?
    return false unless user.detected_timezone == user.detected_timezone_js

    user.timezone != user.detected_timezone && user.ignored_timezone != user.detected_timezone
  end

  def check_user!(ip_address)
    return if ip_address.blank? || local_ip_address?(ip_address)

    timezone = detected_timezone(ip_address)
    return if timezone == user.detected_timezone

    user.update! detected_timezone: timezone
  end

  def update!
    user.update! timezone: user.detected_timezone, ignored_timezone: nil
  end

  def ignore!
    user.update! ignored_timezone: user.detected_timezone
  end

  private

    def local_ip_address?(ip_address)
      %w[127.0.0.1 ::1].include?(ip_address)
    end

    def detected_timezone(ip_address)
      Rails.cache.fetch("ip_address_time_zone:#{ip_address}", expires_in: 1.week) do
        geocoder_result = Geocoder.search(ip_address).first

        if geocoder_result.blank?
          Rails.logger.info "UserTimezone: IP Address lookup failed: #{ip_address}"
          return
        end

        raw_zone = geocoder_result.data['timezone']

        if raw_zone.blank?
          Rails.logger.info "UserTimezone: IP Address not found: #{ip_address}"
          return
        end

        matched_zone = convert_timezone(raw_zone)

        if matched_zone.blank?
          Rails.logger.info "UserTimezone: Timezone not found for #{ip_address}: #{raw_zone}"
          return
        end

        matched_zone.name
      end
    end

    def convert_timezone(raw_zone)
      ActiveSupport::TimeZone.all.find { |tz| tz.tzinfo.name == raw_zone }
    end
end
