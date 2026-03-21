require 'rails_helper'

RSpec.describe 'TwilioReplies', type: :request do
  let(:valid_attributes) do
    { 'ToCountry' => 'US',
      'ToState' => 'FL',
      'SmsMessageSid' => 'SMc55a742a32c3487a395dc2805580d839',
      'NumMedia' => '0',
      'ToCity' => 'JACKSONVILLE',
      'FromZip' => '40504',
      'SmsSid' => 'SMc55a742a32c3487a395dc2805580d839',
      'FromState' => 'KY',
      'SmsStatus' => 'received',
      'FromCity' => 'LEXINGTON',
      'Body' => 'Approve ',
      'FromCountry' => 'US',
      'To' => '+13891050431',
      'ToZip' => '',
      'NumSegments' => '1',
      'MessageSid' => 'SMc55a742a32c3487a395dc2805580d839',
      'AccountSid' => 'AC3f05c12f0db06def477e5f07e04d3f42',
      'From' => '+19213961049',
      'ApiVersion' => '2010-04-01' }
  end

  let(:invalid_attributes) { { 'Foo' => 'Bar' } }

  describe 'POST create' do
    describe 'with valid params' do
      it 'returns success' do
        post '/twilio_replies', params: valid_attributes
        expect(response).to have_http_status :ok
      end

      it 'creates a new ContactLog' do
        expect {
          post '/twilio_replies', params: valid_attributes
        }.to change(ContactLog, :count).by(1)
      end
    end

    describe 'with invalid params' do
      it 'raises an error' do
        expect { post '/twilio_replies', params: invalid_attributes }.to raise_error(StandardError)
      end
    end
  end
end
