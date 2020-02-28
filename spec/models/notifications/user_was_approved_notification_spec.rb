require 'rails_helper'

RSpec.describe Notifications::UserWasApprovedNotification, type: :model do
  let!(:admin) { create :admin }
  let(:another) { create :admin }
  let(:user) { create :user }
  let(:notification) { described_class }
  let(:mail) { ActionMailer::Base.deliveries.last }

  describe '#notify_user_ids' do
    context 'when user is approved' do
      subject { notification.send(:notify_user_ids, [user, admin], :email) }

      it { is_expected.to include admin.id }
    end

    context 'when admin is approved' do
      subject { notification.send(:notify_user_ids, [another, admin], :email) }

      it { is_expected.to include admin.id }
      it { is_expected.not_to include another.id }
    end
  end

  describe '#notify!' do
    before do
      ActionMailer::Base.deliveries = []
      notification.notify! [user, admin]
    end

    it 'emails' do
      expect(mail.subject).to eq "User Was Approved on #{I18n.t(:app_name)}"
    end
  end
end
