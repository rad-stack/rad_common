require 'rails_helper'

describe User, type: :model do
  describe 'authy' do
    let(:user) { create :user, mobile_phone: phone_number }
    let(:phone_number) { '(123) 456-7111' }
    let(:new_phone_number) { '(456) 789-0123'}
    let(:authy_id) { '1234567' }

    it 'creates and updates the user on authy' do
      expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: true, id: authy_id))

      expect(user.authy_id).to be_nil
      user.update!(authy_enabled: true)
      expect(user.authy_id).to eq authy_id
    end

    it 'returns a failure message if authy doesnt update' do
      expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: false, message: 'mocked message'))

      user.authy_enabled = true
      user.mobile_phone = new_phone_number
      user.save
      expect(user.errors.full_messages.to_s).to include('Could not register authy user')
    end

    it 'deletes authy user if mobile phone wiped out' do
      # this test is not applicable for projects that require mobile phone presence
      user.update!(authy_enabled: false, mobile_phone: nil)
      expect(user.reload.authy_id).to be_blank
    end

    it "doesn't allow invalid email" do
      user = build :user, mobile_phone: phone_number, email: 'foo@', authy_enabled: true
      user.save
      expect(user.errors.full_messages.to_s).to include('Could not register authy user')
    end
  end
end
