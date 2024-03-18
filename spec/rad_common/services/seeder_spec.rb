require 'rails_helper'

RSpec.describe Seeder, type: :service do
  it 'runs' do
    expect { described_class.new(Rails.logger).seed! }.to change(User, :count)
  end
end
