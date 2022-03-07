require 'rails_helper'

RSpec.describe Seeder, type: :service do
  let(:user_seeds) do
    [{ factory: 'admin', email: 'admin@example.com', first_name: 'Test', last_name: 'Admin', security_role: 'Admin' }]
  end

  before { allow_any_instance_of(RadSeeder).to receive(:seeded_user_config).and_return(user_seeds) }

  it 'runs' do
    described_class.new.seed!
  end
end
