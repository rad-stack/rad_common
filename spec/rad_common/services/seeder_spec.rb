require 'rails_helper'

RSpec.describe Seeder, type: :service do
  before do
    allow_any_instance_of(Notifications::PossibleDuplicateFoundNotification).to receive(:created_by_user)
      .and_return(create(:user))
  end

  it 'runs' do
    described_class.new.seed!
  end
end
