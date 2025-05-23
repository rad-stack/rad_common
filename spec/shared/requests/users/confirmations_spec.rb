require 'rails_helper'

RSpec.describe 'User Confirmations', type: :request do
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:last_email) { deliveries.last }

  describe 'show' do
    before do
      create :admin
      deliveries.clear
    end

    context 'with new user' do
      before do
        get user_confirmation_path, params: { confirmation_token: user.confirmation_token }
        expect(last_email.body.encoded).to include("#{user} has signed up")
      end

      context 'with pending status' do
        let(:user) { create :pending, confirmed_at: nil, confirmation_sent_at: nil }
        let(:message) { 'Review their user registration information and approve them if desired' }

        before { allow(RadConfig).to receive(:pending_users?).and_return true }

        it 'sends a new user sign up email to the site admins', :sign_up_specs, :user_confirmable_specs do
          expect(last_email.body.encoded).to include(message)
        end
      end

      context 'without pending status' do
        let(:user) { create :user, confirmed_at: nil, confirmation_sent_at: nil }
        let(:message) { 'Review their user registration information if desired' }

        before { allow(RadConfig).to receive(:pending_users?).and_return false }

        it 'sends a new user sign up email to the site admins', :sign_up_specs, :user_confirmable_specs do
          expect(last_email.body.encoded).to include(message)
        end
      end
    end

    context 'with existing user changing email address' do
      let(:user) { create :user }

      before do
        user.update! email: "new_#{user.email}"
        deliveries.clear
        get user_confirmation_path, params: { confirmation_token: user.confirmation_token }
      end

      xit "doesn't send a new user sign up email", :user_confirmable_specs do
        expect(deliveries.size).to eq 0
      end
    end
  end
end
