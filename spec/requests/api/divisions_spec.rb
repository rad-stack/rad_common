require 'rails_helper'

describe 'Users API', type: :request do
  let(:division) { create :division }

  describe 'show' do
    context 'when success' do
      it 'shows a division' do
        get "/api/divisions/#{division.id}", headers: { HTTP_AUTHORIZATION: RadicalJwtGenerator.new.token }
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['name']).to eq division.name
      end
    end

    context 'when failure' do
      it 'fails' do
        get "/api/divisions/#{division.id}", headers: { HTTP_AUTHORIZATION: RadicalJwtGenerator.new(-1).token }
        expect(response.status).to eq 403
      end
    end
  end
end
