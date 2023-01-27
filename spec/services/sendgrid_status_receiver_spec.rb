require 'rails_helper'

describe SendgridStatusReceiver, type: :service do
  let(:service) { described_class.new(content) }
  let(:deliveries) { ActionMailer::Base.deliveries }

  let(:content) do
    { event: 'bounce', type: 'block', bounce_classification: 'Reputation', email: Faker::Internet.email }
  end

  before do
    create :admin
    deliveries.clear
  end

  it 'notifies'do
    expect { service.process! }.to change(deliveries, :count).by(1)
  end
end
