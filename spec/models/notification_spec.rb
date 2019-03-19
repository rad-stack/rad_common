require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:admin) { create :super_admin }
  let(:user) { create :user }
  let(:notification) { create :notification, name: 'new_user_signed_up', subject: user }
  let(:enabled) { true }
  let(:user_notification) { create :user_notification, user: admin, notification: notification, enabled: enabled }

  describe 'seed' do
    before { Notification.seed_items }

    it 'seeds' do
      expect(Notification.count).to eq 3
      expect(UserNotification.count).to eq 3
      expect(UserNotification.first.user).to eq admin
    end
  end

  describe '#notify!' do
    let(:admin2) { create :admin }
    let(:user_notification2) { create :user_notification, user: admin2, notification: notification }
    let(:deliveries) { ActionMailer::Base.deliveries }
    let(:first_mail) { deliveries.first }
    let(:last_mail) { deliveries.last }

    before do
      user_notification
      user_notification2

      ActionMailer::Base.deliveries = []
      notification.notify!
    end

    it 'notifies' do
      expect(deliveries.count).to eq 1
      expect(last_mail.subject).to include('New User on')
      expect(last_mail.to).to include(admin.email)
      expect(last_mail.to).to include(admin2.email)
    end
  end

  describe '#notify_list' do
    subject { notification.send(:notify_list) }

    it { is_expected.to include user_notification }

    context 'disabled' do
      let(:enabled) { false }

      it { is_expected.to_not include user_notification }
    end
  end
end
