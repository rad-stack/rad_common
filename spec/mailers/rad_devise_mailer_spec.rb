require 'rails_helper'

describe RadDeviseMailer do
  let(:user) { create :user }
  let(:email) { ActionMailer::Base.deliveries.last }
  let(:token) { 'foo' }

  before { ActionMailer::Base.deliveries = [] }

  describe 'invitation_instructions' do
    before { user.invite! }

    it 'has the subject' do
      expect(email.subject).to eq "Invitation to Join #{RadConfig.app_name!}"
    end

    it 'has the body' do
      expect(email.body.encoded).to include 'Someone has invited you to Demo Foo'
    end
  end

  describe 'confirmation_instructions' do
    before { described_class.confirmation_instructions(user, token).deliver_now }

    it 'has the subject' do
      expect(email.subject).to include 'Confirmation instructions'
    end

    it 'has the instructions' do
      expect(email.body.encoded).to include 'Here are your confirmation instructions.'
    end
  end
end
