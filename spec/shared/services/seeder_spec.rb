require 'rails_helper'

RSpec.describe Seeder, type: :service do
  it 'runs', :vcr do
    described_class.new.seed!
  end
end
