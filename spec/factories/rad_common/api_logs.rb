FactoryBot.define do
  factory :api_log do
    service_name { 'TestService' }
    http_method { %w[GET POST PATCH DELETE].sample }
    url { "https://api.example.com/#{Faker::Internet.slug}" }
    response_status { 200 }
    success { true }
    duration_ms { rand(10.0..500.0).round(2) }
    request_headers { { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }
    response_body { { 'status' => 'ok' } }

    trait :failed do
      success { false }
      response_status { [400, 401, 403, 404, 500, 502, 503].sample }
      error_message { Faker::Lorem.sentence }
    end

    trait :with_credential_key do
      credential_key_name { 'EXAMPLE_API_KEY' }
    end

    trait :with_request_body do
      request_body { { 'name' => Faker::Name.name, 'email' => Faker::Internet.email } }
    end
  end
end
