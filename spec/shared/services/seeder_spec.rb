require 'rails_helper'

RSpec.describe Seeder, type: :service do
  it 'runs' do
    expect { described_class.new.seed! }.not_to raise_error
  end
end
