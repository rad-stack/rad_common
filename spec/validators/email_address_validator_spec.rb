require 'rails_helper'

class TestModel
  include ActiveModel::Model
  attr_accessor :email

  def initialize(email)
    @email = email
  end

  def []=(attribute, value)
    public_send("#{attribute}=", value)
  end

  validates_with EmailAddressValidator, fields: %i[email]
end

RSpec.describe EmailAddressValidator, type: :validator do
  subject { TestModel.new(email) }

  context 'when the email is nil' do
    let(:email) { nil }
    it { is_expected.to be_valid }
  end

  context 'when the email is blank' do
    let(:email) { '' }
    it { is_expected.to be_valid }
  end

  context 'when the email is present' do
    context 'standard format' do
      let(:email) { Faker::Internet.email }
      it { is_expected.to be_valid }
    end

    it 'can not be valid' do
      invalid_items = ['test@example.com,,',
                       'bar.foo@yahoo.com,',
                       '.....@a....',
                       'oh.boyyyd@SOME+THING-ODD!!.com',
                       'a.b@example,com',
                       'a.b@example,co.de',
                       'foo bar',
                       'foo@@bar.com']

      invalid_items.each do |item|
        model = TestModel.new(item)
        expect(model).to be_invalid
        expect(model.errors.full_messages.to_s).to include 'Email is not written in a valid format'
      end
    end
  end
end
