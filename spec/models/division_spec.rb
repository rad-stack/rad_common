require 'rails_helper'

describe Division, type: :model do
  let(:division) { create :division }
  let(:app) { FirebaseApp.find(1) }

  describe '#firebase_sync' do
    before do
      allow_any_instance_of(Firebase::Client).to receive(:update).and_return(Firebase::Response.new(nil))
      allow_any_instance_of(Firebase::Client).to receive(:delete).and_return(Firebase::Response.new(nil))
      allow_any_instance_of(Firebase::Response).to receive(:success?).and_return(true)
      allow_any_instance_of(User).to receive(:update_firebase_info).and_return(nil)
    end

    it 'syncs' do
      division.firebase_sync(app)
    end
  end
end
