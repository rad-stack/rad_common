require 'rails_helper'

RSpec.describe RadicalTwilio, type: :service do
  let(:twilio_format) { '+19049995555' }
  let(:human_format) { '(904) 999-5555' }

  describe 'twilio_to_human_format' do
    it 'converts twilio format to human format' do
      expect(described_class.twilio_to_human_format(twilio_format)).to eq(human_format)
    end
  end

  describe 'human_to_twilio_format' do
    it 'converts human format to human format' do
      expect(described_class.human_to_twilio_format(human_format)).to eq(twilio_format)
    end
  end
end
