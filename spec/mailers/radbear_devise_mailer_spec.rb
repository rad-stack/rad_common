require 'rails_helper'

describe RadbearDeviseMailer, type: :mailer do
  let(:user) { create :user }
  let(:email) { ActionMailer::Base.deliveries.last }

  before { ActionMailer::Base.deliveries = [] }

  describe '#confirmation_instructions' do
    let(:token) { 'foo' }

    before { described_class.confirmation_instructions(user, token).deliver_now }

    it 'has the subject' do
      expect(email.subject).to include 'Confirmation instructions'
    end

    it 'has the instructions' do
      expect(email.body.encoded).to include 'Here are your confirmation instructions.'
    end
  end

  pending 'uses portal host name in links'  # see RadbearDeviseMailer.default_url_options
end
