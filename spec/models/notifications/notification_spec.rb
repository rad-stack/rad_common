require 'rails_helper'

RSpec.describe Notifications::Notification, type: :model do
  let!(:admin) { create :admin }
  let(:notification) { Notifications::NewUserSignedUpNotification.new }

  describe '#notify_list' do
    subject { notification.send(:notify_list) }

    # TODO: if this is enabled, another test fails
    xit { is_expected.to eq [admin] }

    context 'when user opts out' do
      let!(:another) { create :admin }

      before do
        create :notification_setting, user: admin,
                                      notification_type: 'Notifications::NewUserSignedUpNotification',
                                      enabled: false
      end

      # TODO: why do these fail and the next one using different syntax passes?
      xit { is_expected.to include another }
      xit { is_expected.to_not include admin }

      it 'excludes them' do
        expect(subject).to include another
        expect(subject).to_not include admin
      end
    end
  end

  describe '#notify_user_ids' do
    subject { notification.send(:notify_user_ids) }
    it { is_expected.to eq [admin.id] }
  end
end
