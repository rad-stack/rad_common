class PushNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(app_id, user_id, subject, message, badge)
    app = FirebaseApp.find(app_id)
    user = User.find_by(id: user_id)

    return unless user

    return if Rails.env.test? || user.firebase_id.blank?

    raise 'missing subject' if subject.blank?
    raise 'missing message' if message.blank?

    device_tokens = user.firebase_device_tokens(app)
    return if device_tokens.nil?

    device_tokens.each do |device_token|
      uri = URI(app.push_url)
      notification = { title: subject, body: message, badge: badge, sound: 'default' }
      array_to_send = { to: device_token, notification: notification }
      json = array_to_send.to_json

      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json'
      req['Authorization'] = "key= #{app.push_key}"
      req.body = json

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.request(req)

      unless res.code == '200'
        raise RadicallyIntermittentException, "#{res.body}"
      end
    end
  end
end
