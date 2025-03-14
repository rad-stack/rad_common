require 'rails_helper'

RSpec.describe UserTimezone, type: :service do
  let(:user) { create :user, timezone: existing_timezone, detected_timezone: detected_timezone }
  let(:existing_timezone) { 'Eastern Time (US & Canada)' }
  let(:detected_timezone) { 'Pacific Time (US & Canada)' }
  let(:new_detected_timezone) { 'Mountain Time (US & Canada)' }
  let(:user_ip) { '192.168.1.1' }
  let(:new_ip) { '203.0.113.45' }

  before { allow_any_instance_of(described_class).to receive(:local_ip_address?).and_return(false) }

  describe '#check_user!' do
    context 'when IP address changes' do
      before do
        allow_any_instance_of(described_class)
          .to receive(:detected_timezone)
          .with(new_ip)
          .and_return(new_detected_timezone)
      end

      it 'updates detected timezone' do
        expect {
          described_class.new(user).check_user!(new_ip)
          user.reload
        }.to change(user, :detected_timezone).from(detected_timezone).to(new_detected_timezone)
      end
    end

    context 'when IP address stays the same' do
      before do
        allow_any_instance_of(described_class)
          .to receive(:detected_timezone)
          .with(user_ip)
          .and_return(detected_timezone)
      end

      it 'does not update detected timezone' do
        expect {
          described_class.new(user).check_user!(user_ip)
          user.reload
        }.not_to change(user, :detected_timezone)
      end
    end

    context 'when IP address is blank' do
      it 'does not update detected timezone' do
        expect {
          described_class.new(user).check_user!(nil)
          user.reload
        }.not_to change(user, :detected_timezone)
      end
    end
  end
end
