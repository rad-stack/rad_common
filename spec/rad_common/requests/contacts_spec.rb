require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  let(:valid_attributes) { { your_email_address: Faker::Internet.email, subject: 'foo', message: 'bar' } }

  describe 'POST create' do
    it 'creates sends a message' do
      expect {
        post '/contact_us', params: { contact_us: valid_attributes }
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end
