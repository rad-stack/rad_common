require 'rails_helper'

class TestEmailModel
  include ActiveModel::Model
  attr_accessor :email_by_other_name, :running_global_validity

  def initialize(email_by_other_name)
    @email_by_other_name = email_by_other_name
  end

  def []=(attribute, value)
    public_send("#{attribute}=", value)
  end

  validates_with EmailAddressValidator, fields: %i[email_by_other_name]
end

class TestEmailArrayModel
  include ActiveModel::Model
  attr_accessor :email

  def initialize(email)
    @email = email
  end

  def []=(attribute, value)
    public_send("#{attribute}=", value)
  end

  validates_with EmailAddressValidator, fields: [:email]
end

RSpec.describe EmailAddressValidator, type: :validator do
  subject(:result) { TestEmailModel.new(email) }

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
        model = TestEmailModel.new(item)
        expect(model).to be_invalid
        expect(model.errors.details.first[0]).to eq :email_by_other_name
        expect(model.errors.full_messages.to_s).to include 'Email by other name is not written in a valid format. '\
                                                           'Email cannot have capital letters, domain must be less '\
                                                           'than 62 characters and does not allow special characters.'
      end
    end
  end

  describe 'send grid', :vcr do
    before { allow(RadicalSendGrid).to receive(:send_grid_enabled?).and_return(true) }

    # These tests need to be disabled because only live credentials can be used
    # To run the tests locally, uncomment the sendgrid credentials in .env.test and run these
    # Do not commit any changes to git

    context 'with valid email' do
      let(:email) { 'support@invest.ally.com' } # just grabbed any ole email address from the web

      xit 'validates' do
        model = TestEmailModel.new(email)
        expect(model.valid?).to eq(true)
      end
    end

    context 'with invalid email' do
      let(:email) { 'support@invest.ally.xyz' }
      let(:error_message) { 'Email by other name does not appear to be a valid email address' }

      xit 'invalidates' do
        model = TestEmailModel.new(email)
        expect(model.valid?).to eq(false)
        expect(model.errors.full_messages.first).to eq(error_message)
      end
    end
  end
end
