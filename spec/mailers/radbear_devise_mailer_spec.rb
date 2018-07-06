require 'rails_helper'

describe RadbearDeviseMailer, type: :mailer do
  let(:user) { create :user }
  let(:email) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries = [] }

  describe '#confirmation_instructions' do
    let(:token) { 'foo' }

    before { RadbearDeviseMailer.confirmation_instructions(user, token).deliver_now }

    it 'should have the subject' do
      expect(email.subject).to include 'Confirmation instructions'
    end

    it 'should have the instructions' do
      expect(email.body.encoded).to include 'Here are your confirmation instructions.'
    end
  end
end
