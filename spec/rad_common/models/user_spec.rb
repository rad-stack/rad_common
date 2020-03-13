require 'rails_helper'

describe User, type: :model do
  let(:user) { create :user }
  let(:active_status) { create :user_status, :active }
  let(:inactive_status) { create :user_status, :inactive }

  let(:attributes) do
    { first_name: 'Example',
      last_name: 'User',
      authy_enabled: false,
      mobile_phone: '(999) 231-1111',
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password' }
  end

  describe 'validate' do
    it 'rejects unauthorized email addresses' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. user@foo.com user@foo.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'rejects invalid email addresses' do
      addresses = ['foo @example.com', '.b ar@example.com']

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is invalid'
      end
    end

    it 'allows valid email addresses' do
      addresses = %w[joe@example.com bob@example.com sally@example.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).to be_valid
      end
    end
  end

  describe 'external user' do
    let(:attr) do
      { first_name: 'Example',
        last_name: 'User',
        authy_enabled: false,
        mobile_phone: '(999) 231-1111',
        password: 'changeme',
        password_confirmation: 'changeme',
        user_status: active_status,
        external: true }
    end

    it 'allows invalid email addresses for inactive users' do
      addresses = %w[user@bar.com user@foo.com]

      addresses.each do |address|
        user = described_class.new(attr.merge(email: address, user_status: inactive_status))
        expect(user).to be_valid
      end
    end

    it 'allows valid email addresses' do
      addresses = %w[joe@aclientcompany.com bob@aclientcompany.com sally@aclientcompany.com]

      addresses.each do |address|
        user = described_class.new(attr.merge(email: address))
        expect(user).to be_valid
      end
    end
  end

  describe 'devise lockable' do
    subject { user.access_locked? }

    before { attempts.times { user.valid_for_authentication? { false } } }

    context 'without enough attempts' do
      let(:attempts) { 5 }

      it { is_expected.to be false }
    end

    context 'with exactly enough attempts' do
      let(:attempts) { 10 }

      it { is_expected.to be true }
    end

    context 'with more than enough attempts' do
      let(:attempts) { 15 }

      it { is_expected.to be true }
    end
  end
end
