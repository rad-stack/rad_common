require 'rails_helper'

describe RadDeviseMailer, type: :mailer do
  let(:user) { create :user }
  let(:email) { ActionMailer::Base.deliveries.last }
  let(:token) { 'foo' }

  before { ActionMailer::Base.deliveries = [] }

  describe 'invitation_instructions' do
    subject { email.body.encoded }

    context 'when internal' do
      before { user.invite! }

      it { is_expected.to include 'Someone has invited you to Demo Foo' }
    end

    context 'when external' do
      let(:user) { create :user, :external }

      before { user.invite! }

      it { is_expected.to include 'Someone has invited you to Dummy Patient Portal' }
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
