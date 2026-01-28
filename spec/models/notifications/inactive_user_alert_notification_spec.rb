require 'rails_helper'

RSpec.describe Notifications::InactiveUserAlertNotification, :user_expirable_specs do
  let!(:admin) { create :admin }
  let(:expired_user) { create :user, last_activity_at: 98.days.ago }
  let(:mail) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries = [] }

  describe 'password reset attempt' do
    let(:notification_type) { described_class.main(user: expired_user, method_name: 'send_reset_password_instructions') }

    before { notification_type.notify! }

    it 'sends notification to admins' do
      expect(mail.to).to include admin.email
      expect(mail.subject).to eq 'Inactive User Alert'
    end

    it 'includes the user info and reason in the message' do
      expect(mail.text_part.body.to_s).to include expired_user.to_s
      expect(mail.text_part.body.to_s).to include expired_user.email
      expect(mail.text_part.body.to_s).to include 'reset their password'
      expect(mail.text_part.body.to_s).to include 'expired account due to inactivity'
    end
  end

  describe 'sign in attempt' do
    let(:notification_type) { described_class.main(user: expired_user, method_name: 'sign_in_attempt') }

    before { notification_type.notify! }

    it 'sends notification to admins' do
      expect(mail.to).to include admin.email
      expect(mail.subject).to eq 'Inactive User Alert'
    end

    it 'includes the user info and reason in the message' do
      expect(mail.text_part.body.to_s).to include expired_user.to_s
      expect(mail.text_part.body.to_s).to include expired_user.email
      expect(mail.text_part.body.to_s).to include 'sign in'
      expect(mail.text_part.body.to_s).to include 'expired account due to inactivity'
    end
  end

  describe 'subject_record' do
    let(:notification_type) { described_class.main(user: expired_user, method_name: 'sign_in_attempt') }

    it 'returns the user' do
      expect(notification_type.subject_record).to eq expired_user
    end
  end
end
