require 'rails_helper'

RSpec.describe Seeder, type: :service do
  let(:user) { create :user }
  let(:admin) { create :admin }

  before do
    allow_any_instance_of(Notifications::PossibleDuplicateFoundNotification).to receive(:created_by_user)
      .and_return(user)
    allow_any_instance_of(Notifications::PossibleDuplicateAdminNotification).to receive(:created_by_user)
      .and_return(admin)
  end

  it 'runs' do
    described_class.new.seed!
  end
end
