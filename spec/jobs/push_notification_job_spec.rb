require 'rails_helper'

describe PushNotificationJob do
  let(:user) { create(:user, id: 9000, firebase_id: '9000') }

  it 'shows exception if server returned error', :vcr do
    expect { described_class.perform_now(user.id, 'test', 'this is a test message', nil) }.to raise_exception
  end

  it 'processes valid push notification key without error', :vcr do
    allow_any_instance_of(User).to receive(:firebase_device_tokens).and_return(['eaRGtEwMoeQ:APA91bFvQAqnXU0F1yhvotXohwOLkflP41ugVfMfLZZZI8BtaBiJwH6vY7U7JyHUyQO3FgPnRFyVtr_g19wK7GuPO5TNLp8sbAHTuAoDaNFgCU6_-rAWjyLWkneLogKqxyMD09uEqgC-'])
    expect { described_class.perform_now(user.id, 'test', 'this is a test message', nil) }.to_not raise_exception
  end
end
