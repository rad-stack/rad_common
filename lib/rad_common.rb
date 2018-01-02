require "rad_common/engine"

module RadCommon
  def self.facebook(response_data, current_user)
    data_info = response_data['info']
    raw_info = response_data['extra']['raw_info']

    credentials = response_data['credentials']
    access_token = credentials['token']

    if credentials['expires'].present? && credentials['expires']
      expires_at = Time.at(credentials['expires_at'])
    end

    if raw_info['timezone'].present? && !raw_info['timezone'].blank?
      timezone = RadCommon.convert_timezone(raw_info['timezone'])
    end

    provider_id = response_data['uid']
    avatar = "https://graph.facebook.com/#{provider_id}/picture?type=large"
    email = data_info["email"]
    first_name = data_info["name"].split(" ").first
    last_name = data_info["name"].split(" ").last

    return RadCommon.find_for_provider_oauth("facebook", provider_id, nil, email, access_token, nil, expires_at, timezone, first_name, last_name, avatar, current_user)
  end

  def self.find_for_provider_oauth(provider, provider_id, device_id, email, access_token, access_secret, expires_at, timezone, first_name, last_name, avatar, current_user)
    message = nil

    if current_user
      message = update_provider_data(current_user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
      user = current_user
    else
      user = User.find_by_email(email)
      if user
        message = RadCommon.update_provider_data(user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
      else
        users = User.where("#{provider}_id = ?", provider_id)
        user = users.first if users.count != 0
        if user
          message = update_provider_data(user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
        else
          user = User.find_by_device_id(device_id) if device_id
          if user
            message = update_provider_data(user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
          else
            if Rails.application.config.enable_facebook
              user = User.new
              user.password = Devise.friendly_token[0,20]
              message = update_provider_data(user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
            else
              user = nil
              message = "You must first register as a user before connectiong this social media service to your account"
            end
          end
        end
      end
    end

    return user, message
  end

  def self.convert_timezone(raw_timezone)
    timezone = ""

    offset = raw_timezone.to_i

    #todo will need to determine whether the locale participates in dst or not, but for now this will work properly in the U.S.
    offset = offset - 1 if Time.now.in_time_zone("Eastern Time (US & Canada)").isdst

    if offset == -5
      timezone = "Eastern Time (US & Canada)"
    elsif offset == -6
      timezone = "Eastern Time (US & Canada)"
    elsif offset == -7
      timezone = "Mountain Time (US & Canada)"
    elsif offset == -8
      timezone = "Pacific Time (US & Canada)"
    else
      timezone = ActiveSupport::TimeZone.new(offset).name
    end

    timezone = default_timezone if timezone.blank?
    timezone
  end

  def self.default_timezone
    "Eastern Time (US & Canada)"
  end

  def self.devise_confirmable?
    Devise.mappings[:user].confirmable?
  end

  private

    def self.update_provider_data(user, provider, provider_id, email, first_name, last_name, access_token, access_secret, timezone, expires_at, avatar)
      if devise_confirmable?
        if user.id
          user.skip_reconfirmation!
        else
          user.skip_confirmation!
        end
      end

      user.email = email
      user.timezone = timezone if timezone
      user.provider_avatar = avatar if avatar

      if !user.respond_to?(:profile_verified) || !user.profile_verified
        user.first_name = first_name
        user.last_name = last_name
      end

      user.send("#{provider}_id=", provider_id)
      user.send("#{provider}_access_token=", access_token)
      user.send("#{provider}_access_secret=", access_secret) if User.column_names.include?("#{provider}_access_secret")
      user.send("#{provider}_expires_at=", expires_at) if User.column_names.include?("#{provider}_expires_at")

      message = user.errors.full_messages.join(", ") if !user.save
    end
end
