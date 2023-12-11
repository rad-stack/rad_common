require 'rails_helper'

RSpec.describe 'User Confirmations', type: :request do
  describe 'show' do
    before do
      create :admin
      ActionMailer::Base.deliveries.clear

      get user_confirmation_path, params: { confirmation_token: new_user.confirmation_token }
      expect(ActionMailer::Base.deliveries.last.body.encoded).to include("#{new_user} has signed up")
    end

    context 'with pending status' do
      let(:new_user) { create :pending, confirmed_at: nil, confirmation_sent_at: nil }
      let(:message) { 'Review their user registration information and approve them if desired' }

      before { allow(RadConfig).to receive(:pending_users?).and_return true }

      it 'sends a new user sign up email to the site admins', :sign_up_specs, :user_confirmable_specs do
        expect(ActionMailer::Base.deliveries.last.body.encoded).to include(message)
      end
    end

    context 'without pending status' do
      let(:new_user) { create :user, confirmed_at: nil, confirmation_sent_at: nil }
      let(:message) { 'Review their user registration information if desired' }

      before { allow(RadConfig).to receive(:pending_users?).and_return false }

      it 'sends a new user sign up email to the site admins', :sign_up_specs, :user_confirmable_specs do
        expect(ActionMailer::Base.deliveries.last.body.encoded).to include(message)
      end
    end
  end
end
