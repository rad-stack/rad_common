require 'rails_helper'

RSpec.describe PhoneSMSSender, type: :service do
  let(:from_user) { create :user }
  let(:mobile_phone) { '(618) 722-2169' }
  let(:message) { 'test message' }
  let(:sms_sender) { described_class.new(message, from_user.id, mobile_phone, nil, false, twilio_log_attachment_ids) }
  let(:twilio_log_attachment_ids) { [] }

  before { allow(RadRetry).to receive(:exponential_pause) }

  describe 'send', :vcr do
    subject(:result) { sms_sender.send! }

    context 'when operating normally' do
      context 'when successful' do
        it { is_expected.to be true }
      end

      context 'when failure' do
        context 'when blacklisted' do
          let(:mobile_phone) { '(500) 555-0004' }

          it { is_expected.to be false }
        end
      end
    end

    context 'when not operating normally' do
      let(:mobile_phone) { '(500) 555-0009' }

      it 'raises exception' do
        expect { result }.to raise_error RuntimeError
      end
    end
  end

  describe 'twilio_log_attachment' do
    subject { sms_sender.send(:augment_message, message, false) }

    let(:message) { 'Hey check out this document!' }
    let(:twilio_log_attachment_ids) { [attachment.id] }
    let(:attachment) do
      twilio_log_attachment = TwilioLogAttachment.new
      twilio_log_attachment.attachment.attach(io: file, filename: 'test.pdf')
      twilio_log_attachment.save!
      twilio_log_attachment
    end
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.pdf')) }
    let(:perm_url) { AttachmentUrlGenerator.permanent_attachment_url(attachment) }


    context 'with other file type besides image' do
      it 'appends permanent url to message' do
        expect(subject).to include perm_url
      end
    end
  end

  describe 'augment_message' do
    subject { sms_sender.send(:augment_message, message, force_opt_out) }

    let(:force_opt_out) { false }

    context 'with full question' do
      let(:message) { 'Hey man, can I borrow your surfboard?' }

      it { is_expected.to eq 'Hey man, can I borrow your surfboard? To no longer receive text messages, text STOP.' }
    end

    context 'with full sentence' do
      let(:message) { 'Your surfboard is lame.' }

      it { is_expected.to eq 'Your surfboard is lame. To no longer receive text messages, text STOP.' }
    end

    context 'without full sentence' do
      let(:message) { "I'm taking your surfboard" }

      it { is_expected.to eq "I'm taking your surfboard - To no longer receive text messages, text STOP" }

      context 'when opt out message already sent' do
        before do
          create :twilio_log,
                 opt_out_message_sent: true,
                 sent: true,
                 to_number: mobile_phone
        end

        it { is_expected.to eq "I'm taking your surfboard" }

        context 'with force opt out option' do
          let(:force_opt_out) { true }

          it { is_expected.to eq "I'm taking your surfboard - To no longer receive text messages, text STOP" }
        end
      end
    end
  end
end
