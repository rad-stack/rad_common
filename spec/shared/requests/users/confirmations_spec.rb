require 'rails_helper'

RSpec.describe 'User Confirmations', type: :request do
  describe 'show' do
    let(:admin) { create :admin }
    let(:new_user) { create :pending, confirmed_at: nil, confirmation_sent_at: nil }

    before do
      create :new_user_signed_up_notification, security_roles: [admin.security_roles.first]
      ActionMailer::Base.deliveries = []
    end

    xit 'sends a new user sign up email to the site admins', user_confirmable_specs: true do
      get user_confirmation_path, params: { confirmation_token: new_user.confirmation_token }
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include("#{new_user} has signed up")
    end
  end
end
