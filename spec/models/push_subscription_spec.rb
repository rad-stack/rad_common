require 'rails_helper'

RSpec.describe PushSubscription do
  let(:user) { create :user }
  let(:push_subscription) { create :push_subscription, user: user }

  describe 'validations' do
    it { expect(push_subscription).to be_valid }

    it 'validates uniqueness of endpoint' do
      duplicate = build(:push_subscription, endpoint: push_subscription.endpoint)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:endpoint]).to include('has already been taken')
    end

    it 'requires endpoint' do
      subscription = build(:push_subscription, endpoint: nil)
      expect(subscription).not_to be_valid
    end

    it 'requires p256dh' do
      subscription = build(:push_subscription, p256dh: nil)
      expect(subscription).not_to be_valid
    end

    it 'requires auth' do
      subscription = build(:push_subscription, auth: nil)
      expect(subscription).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(push_subscription.user).to eq user
    end
  end
end
