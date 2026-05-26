require 'rails_helper'

RSpec.describe 'Devise Twilio Verify' do
  let(:user) { create :user, mobile_phone: create(:phone_number, :mobile) }

  before do
    Rails.cache.write('rate_limit:twilio_verify', 0, expires_in: 5.minutes)
    user.security_roles.update_all(two_factor_auth: true)
    login_as user, scope: :user
  end

  describe 'POST /auth/request-sms' do
    context 'when twilio reports max send attempts reached' do
      before do
        twilio_response = double('twilio_response',
                                 status_code: 429,
                                 body: { 'code' => 60_203,
                                         'message' => 'Max send attempts reached',
                                         'details' => nil,
                                         'more_info' => nil })
        allow(TwilioVerifyService).to receive(:send_token)
          .and_raise(Twilio::REST::RestError.new('Unable to create record', twilio_response))
      end

      it 'renders the verify form with a wait message instead of a 500' do
        post user_request_sms_path

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Too many verification code requests')
      end
    end
  end
end
