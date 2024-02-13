require 'rails_helper'

describe 'Users API' do
  let(:division) { create :division }
  let(:headers) { { HTTP_AUTHORIZATION: RadJwt.new.generate_token(valid_for_minutes) } }

  describe 'show' do
    context 'when success' do
      let(:valid_for_minutes) { 5 }

      it 'shows a division' do
        get "/api/divisions/#{division.id}", headers: headers
        expect(response).to have_http_status :ok
        expect(response.parsed_body['name']).to eq division.name
      end
    end

    context 'when failure' do
      let(:valid_for_minutes) { -1 }

      it 'fails with expired date' do
        get "/api/divisions/#{division.id}", headers: headers
        expect(response).to have_http_status :forbidden
      end
    end
  end
end
