require 'rails_helper'

RSpec.describe 'User Confirmations', type: :request do
  describe 'show' do
    it 'sends a new user sign up email to the site admins' do
      create :admin
      new_user = create(:pending, confirmed_at: nil, confirmation_sent_at: nil)
      ActionMailer::Base.deliveries = []
      get '/users/confirmation', params: { confirmation_token: new_user.confirmation_token }
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include('Review their user registration information and approve them if desired.')
    end
  end
end
