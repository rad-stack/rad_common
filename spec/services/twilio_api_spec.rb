require 'rails_helper'

RSpec.describe TwilioApi, type: :service do
  describe '#update_user' do
    let(:user) { create :user }
    let(:authy_id) { 12344 }
    let(:new_phone_number) { '123-456-7111' }

    subject do
      described_class.new(user, { authy_id: authy_id, mobile_phone: new_phone_number })
    end

    context 'create succeeds' do
      before do
        expect(Authy::API).to receive(:delete_user).and_return({
          "message": "User removed from application",
          "success": true
        })
      end

      it 're-creates the user on Twilio', :vcr do
        expect(subject.update_user).to eq(true)
      end

      it 'updates user authy_id', :vcr do
        expect do
          subject.update_user
        end.to change { user.authy_id }
      end
    end

    context 'create fails' do
      before do
        expect(Authy::API).to receive(:register_user).and_return(double(:response, ok?: false))
      end

      it 'returns false' do
        expect(subject.update_user).to eq(false)
      end
    end
  end

  describe '.user_attributes_hash' do
    let(:user_mobile_phone) { '000000000' }
    let(:user) { build(:user, mobile_phone: user_mobile_phone) }
    let(:mobile_phone_param) { '999999999' }
    let(:attributes) do
      ActionController::Parameters.new({ mobile_phone: mobile_phone_param })
    end
    context 'mobile phone attribute' do
      it 'prefers the mobile phone attribute over the user mobile phone attr' do
        hash = described_class.new(user, attributes).user_attributes_hash
        expect(hash[:country_code]).to eq('1')
        expect(hash[:cellphone]).to eq(mobile_phone_param)
        expect(hash[:email]).to eq(user.email)
      end
    end

    context 'no mobile phone attribute' do
      let(:attributes) do
        ActionController::Parameters.new({})
      end
      it 'assigns user mobile phone attribute' do
        hash = described_class.new(user, attributes).user_attributes_hash
        expect(hash[:country_code]).to eq('1')
        expect(hash[:cellphone]).to eq(user_mobile_phone)
        expect(hash[:email]).to eq(user.email)
      end
    end

    context 'email attributes' do
      let(:new_email) { 'new@example.com' }
      let(:attributes) do
        ActionController::Parameters.new({ email: new_email })
      end
      it 'prefers the email attribute over the user email attr' do
        hash = described_class.new(user, attributes).user_attributes_hash
        expect(hash[:email]).to eq(new_email)
      end
    end

    context 'no email attribute' do
      let(:attributes) do
        ActionController::Parameters.new({})
      end
      it 'assigns user mobile phone attribute' do
        hash = described_class.new(user, attributes).user_attributes_hash
        expect(hash[:email]).to eq(user.email)
      end
    end
  end
end
