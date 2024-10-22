require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }
  let(:last_email) { deliveries.last }
  let(:user) { create :user }
  let(:attorney) { create :attorney }
  let(:event_type) { 'bounce' }
  let(:contact_log) { create :contact_log, :email, record: attorney, content: 'This is a test' }

  let(:content) do
    { event: event_type,
      type: 'block',
      email: user.email,
      host_name: RadConfig.host_name!,
      contact_log_id: contact_log.id }
  end

  before do
    create :contact_log_recipient, :email, contact_log: contact_log, email: user.email
    create :admin

    deliveries.clear
  end

  it 'notifies' do
    service.process!

    expect(last_email.subject).to include 'Outgoing Email Failed'
    expect(last_email.body.encoded).to include 'Attorney'
    expect(last_email.body.encoded).to include contact_log.content
  end

  it 'ignores when a contact log was previously deleted' do
    contact_log.destroy!
    expect(service.process!).to be_nil
  end
end
