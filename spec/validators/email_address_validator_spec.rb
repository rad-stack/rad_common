require 'rails_helper'

RSpec.describe EmailAddressValidator, type: :validator do
  subject(:result) { build :division, invoice_email: email }

  context 'when the email is nil' do
    let(:email) { nil }

    it { is_expected.to be_valid }
  end

  context 'when the email is blank' do
    let(:email) { '' }

    it { is_expected.to be_valid }
  end

  context 'when the email is present' do
    context 'with standard format' do
      let(:email) { Faker::Internet.email }

      it { is_expected.to be_valid }
    end

    context 'with capital letters' do
      let(:email) { "A#{Faker::Internet.email}" }

      it 'downcases before validating' do
        expect(result).to be_valid
      end
    end

    it 'can not be valid' do
      invalid_items = ['another@example@com',
                       'test@example.com,,',
                       'bar.foo@yahoo.com,',
                       '.....@a....',
                       'oh.boyyyd@SOME+THING-ODD!!.com',
                       'a.b@example,com',
                       'a.b@example,co.de',
                       'foo bar',
                       'foo@@bar.com',
                       'foo@example.com, bar@example.com',
                       'foob@example.com, barf@example.com, xanz@example.com']

      invalid_items.each do |item|
        model = build(:division, invoice_email: item)

        expect(model).to be_invalid
        expect(model.errors.details.first[0]).to eq :invoice_email
        expect(model.errors.full_messages.to_s).to include 'Invoice email is not written in a valid format. ' \
                                                           'Email cannot have capital letters, domain must be less ' \
                                                           'than 62 characters and does not allow special characters.'
      end
    end
  end

  describe 'send grid', :vcr do
    let(:good_email) { 'support@invest.ally.com' } # just grabbed any ole email address from the web
    let(:bad_email) { 'support@radicalbear.co' }
    let!(:division) { build :division, invoice_email: email }

    before { allow_any_instance_of(RadicalSendGrid).to receive(:sendgrid_enabled?).and_return true }

    context 'with valid email' do
      let(:email) { good_email }

      it 'is valid' do
        expect(division.valid?).to be(true)
      end
    end

    context 'with invalid email' do
      let(:email) { bad_email }
      let(:error_message) { 'Invoice email does not appear to be a valid email address' }

      it 'is invalid' do
        expect(division.valid?).to be(false)
        expect(division.errors.full_messages.first).to eq(error_message)
      end

      context 'when email not changed' do
        before do
          division.save! validate: false
          division.additional_info = "bad email grandfathered in, that's fine bro, let it go"
        end

        it 'is valid' do
          expect(division.valid?).to be(true)
        end
      end
    end
  end
end
