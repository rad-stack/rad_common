require 'rails_helper'

RSpec.describe Seeder, type: :service do
  before { allow(RadConfig).to receive(:twilio_verify_enabled?).and_return false }

  it 'runs' do
    described_class.new.seed!
  end
end
