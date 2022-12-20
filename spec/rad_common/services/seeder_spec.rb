require 'rails_helper'

RSpec.describe Seeder, type: :service do
  before { allow(RadicalConfig).to receive(:authy_enabled?).and_return false }

  it 'runs' do
    described_class.new.seed!
  end
end
