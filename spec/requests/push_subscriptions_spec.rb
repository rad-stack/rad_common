require 'rails_helper'

RSpec.describe 'Push Subscriptions' do
  let(:user) { create :user }
  let(:valid_attributes) do
    {
      endpoint: "https://fcm.googleapis.com/fcm/send/#{SecureRandom.hex(32)}",
      p256dh: Base64.strict_encode64(SecureRandom.random_bytes(65)),
      auth: Base64.strict_encode64(SecureRandom.random_bytes(16)),
      user_agent: 'Mozilla/5.0 Test Browser'
    }
  end

  before do
    login_as user, scope: :user
    allow(RadConfig).to receive(:browser_notifications_enabled?).and_return(true)
    allow(RadConfig).to receive(:vapid_public_key!).and_return('test_public_key')
  end

  describe 'GET vapid_public_key' do
    context 'when browser notifications are enabled' do
      it 'returns the VAPID public key' do
        get vapid_public_key_push_subscriptions_path, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['vapid_public_key']).to eq('test_public_key')
      end
    end

    context 'when browser notifications are disabled' do
      before { allow(RadConfig).to receive(:browser_notifications_enabled?).and_return(false) }

      it 'returns forbidden' do
        get vapid_public_key_push_subscriptions_path, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST create' do
    it 'creates a new push subscription' do
      expect do
        post push_subscriptions_path, params: { push_subscription: valid_attributes }, as: :json
      end.to change(PushSubscription, :count).by(1)

      expect(response).to have_http_status(:ok)
    end

    it 'updates an existing subscription with the same endpoint' do
      existing = create(:push_subscription, user: user, endpoint: valid_attributes[:endpoint])

      expect do
        post push_subscriptions_path, params: { push_subscription: valid_attributes.merge(user_agent: 'Updated Agent') },
                                      as: :json
      end.not_to change(PushSubscription, :count)

      expect(existing.reload.user_agent).to eq('Updated Agent')
    end

    context 'with invalid attributes' do
      it 'returns unprocessable content' do
        post push_subscriptions_path, params: { push_subscription: { endpoint: nil } }, as: :json
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe 'DELETE unsubscribe' do
    let!(:push_subscription) { create(:push_subscription, user: user) }

    it 'destroys the push subscription' do
      expect do
        delete unsubscribe_push_subscriptions_path, params: { endpoint: push_subscription.endpoint }, as: :json
      end.to change(PushSubscription, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end

    context 'when subscription does not exist' do
      it 'returns ok anyway' do
        delete unsubscribe_push_subscriptions_path, params: { endpoint: 'https://example.com/nonexistent' }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when subscription belongs to another user' do
      let(:other_user) { create :user }
      let!(:other_subscription) { create(:push_subscription, user: other_user) }

      it 'does not find the subscription' do
        delete unsubscribe_push_subscriptions_path, params: { endpoint: other_subscription.endpoint }, as: :json
        expect(response).to have_http_status(:ok)
        expect(PushSubscription.find_by(id: other_subscription.id)).to be_present
      end
    end
  end
end
