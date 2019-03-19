require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :controller do
  describe 'show' do
    let(:user) { create(:admin) }
    let(:notification) { create :notification, name: 'new_user_signed_up'}
    let!(:user_notification) { create :user_notification, user: user, notification: notification }

    it 'sends a new user sign up email to the site admins' do
      new_user = create(:pending, confirmed_at: nil, confirmation_sent_at: nil)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      ActionMailer::Base.deliveries = []
      get :show, params: { confirmation_token: new_user.confirmation_token }
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include('Review their user registration information and approve them if desired.')
    end
  end
end
