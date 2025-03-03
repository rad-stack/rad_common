class UserTimezone
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def wrong_timezone?
    return false if user.timezone.blank? || user.detected_timezone.blank?

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
        raw_zone = Geocoder.search(ip_address).first.data['timezone']

        if raw_zone.blank?
          Rails.logger.info "UserTimezone: IP Address not found: #{ip_address}"
          return
        end

        matched_zone = ActiveSupport::TimeZone.all.find { |tz| tz.tzinfo.name == raw_zone }

        if matched_zone.blank?
          Rails.logger.info "UserTimezone: Timezone not found for #{ip_address}: #{raw_zone}"
          return
        end

        matched_zone.name
      end
    end
end
