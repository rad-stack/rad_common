require 'rails_helper'

RSpec.describe Seeder, type: :service do
  before { allow_any_instance_of(Duplicate).to receive(:maybe_notify!) }

  it 'runs' do
    described_class.new.seed!
  end
end
