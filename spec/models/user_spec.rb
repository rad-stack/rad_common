require 'rails_helper'

describe User, type: :model do
  describe 'authy' do
    let(:user) { create :user, mobile_phone: phone_number }
    let(:phone_number) { '(123) 456-7111' }
    let(:new_phone_number) { '(456) 789-0123'}

    it 'creates and updates the user on authy' do
      expect(user.authy_id).to be_nil
      user.update!(authy_enabled: true)
      expect(user.authy_id).to eq '55025407'

      user.update!(mobile_phone: new_phone_number)
      expect(user.authy_id).to eq '15943902'
    end
  end
end
