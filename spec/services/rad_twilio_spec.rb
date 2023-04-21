require 'rails_helper'

RSpec.describe RadTwilio, type: :service do
  let(:twilio_format) { '+19049995555' }
  let(:twilio_format_2) { '19049995555' }
  let(:invalid_twilio_format) { '995555' }
  let(:human_format) { '(904) 999-5555' }
  let(:phone_number) { human_format }
  let(:robocall_url) { 'https://example.com' }

  describe 'send_robocall' do
    it 'runs without error', :vcr do
      described_class.new.send_robocall to: phone_number, url: robocall_url
    end
  end

  describe 'twilio_to_human_format' do
    it 'converts twilio format to human format' do
      expect(described_class.twilio_to_human_format(twilio_format)).to eq(human_format)
    end

    it 'converts alt twilio format to human format' do
      expect(described_class.twilio_to_human_format(twilio_format_2)).to eq(human_format)
    end

    it 'raises error on invalid twilio format' do
      expect { described_class.twilio_to_human_format(invalid_twilio_format) }.to raise_error('invalid twilio number format')
    end
  end

  describe 'human_to_twilio_format' do
    it 'converts human format to human format' do
      expect(described_class.human_to_twilio_format(human_format)).to eq(twilio_format)
    end
  end
end
