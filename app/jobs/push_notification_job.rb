class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id, subject, message, badge)
    app = FirebaseApp.new
    user = User.find_by(id: user_id)

    return unless user

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

      raise RadicallyIntermittentException, res.body.to_s unless res.code == '200'
    end
  end
end
