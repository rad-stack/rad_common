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
    return if ip_address.blank? || ip_address == '127.0.0.1' || ip_address == '::1'

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

    def detected_timezone(ip_address)
      Rails.cache.fetch("ip_address_time_zone:#{ip_address}", expires_in: 1.hour) do
        raw_zone = Geocoder.search(ip_address).first.data['timezone']
        ActiveSupport::TimeZone.all.find { |tz| tz.tzinfo.name == raw_zone }.name
      end
    end
end
