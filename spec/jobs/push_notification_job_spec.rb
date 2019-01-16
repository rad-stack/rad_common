require 'rails_helper'

describe PushNotificationJob do
  let(:user) { create :user, firebase_id: 'foo' }

  it 'runs' do
    PushNotificationJob.perform_now user.id, 'foo', 'bar', 0
    # TODO: assert something if possible
  end
end
