require 'rails_helper'

describe RadContactMailer do
  let(:user) { create :user }
  let(:contact_log) { ContactLog.last }

  before { ActionMailer::Base.deliveries.clear }

  describe '#finish_contact_log' do
    context 'when the mailer sets @contact_log_email_body' do
      let(:body) { 'This is the actual email body content.' }

      before { EmailBodyTestMailer.message_with_body(user.email, 'foo', body).deliver_now }

      it 'persists the email body on the contact log' do
        expect(contact_log.email_body).to eq body
      end

      it 'keeps the subject as the content' do
        expect(contact_log.content).to eq 'foo'
      end

      context 'when the body exceeds the limit' do
        let(:body) { 'a' * (RadContactMailer::EMAIL_BODY_LIMIT + 100) }

        it 'truncates the email body to the limit' do
          expect(contact_log.email_body.length).to eq RadContactMailer::EMAIL_BODY_LIMIT
        end
      end
    end

    context 'when the mailer does not set @contact_log_email_body' do
      before { RadMailer.simple_message(user.email, 'foo', 'bar').deliver_now }

      it 'leaves the email body null' do
        expect(contact_log.email_body).to be_nil
      end
    end
  end
end
