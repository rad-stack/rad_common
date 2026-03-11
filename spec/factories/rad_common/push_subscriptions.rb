FactoryBot.define do
  factory :push_subscription do
    user
    endpoint { "https://fcm.googleapis.com/fcm/send/#{SecureRandom.hex(32)}" }
    p256dh { Base64.strict_encode64(SecureRandom.random_bytes(65)) }
    auth { Base64.strict_encode64(SecureRandom.random_bytes(16)) }
    user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/120.0.0.0' }
  end
end
