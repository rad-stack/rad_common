require 'rails_helper'

describe User, type: :model do
  let(:user) { create :user }
  let(:admin_role) { SecurityRole.find_by(name: 'Admin') }
  let(:app) { FirebaseApp.new }

  let(:attributes) do
    { first_name: 'Example',
      last_name: 'User',
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password' }
  end

  describe '#firebase_device_tokens' do
    let(:tokens) do
      %w[eKUEUPDWW3I:APA91bHdhnsF7bGr8BOz3NcFWJrr1nBrjJDa1Uz-GWmrBC0_YD63asWukwmTn3LBKtZS7stiluDybaBgV4bH0M_AuizdWztyeMeVrrCeNlcPEnkXKln5sjolgH1WOtB6NBpQTc3hR_9F
         dQUulxDx3sk:APA91bGO1YR0b95FMCeIh2FamYYGJyR7LymRziH7Kq9i2GubkOicRcWAuposSVOUi7ZJlRxEwzi6aoK9kUnWUAUEmtJ9svs0WyTyUnjViTtTNoBS6yQZjebeo-ZP-dfr69-OELLBCvxc
         cy2w20Xdg60:APA91bFdlYH0yzzYVmhXl1yp58KM_547ce_hXtEUtURh9CwHHDLynqVjff082bmzO56nsJ5Isz0RmYws6IVOs2VP94DZwrXC5knzKHPkgHP8r5diEqyFmJWnweFanRf5xk0iORnzjIzb]
    end

    subject { user.firebase_device_tokens(app) }

    before { allow_any_instance_of(User).to receive(:firebase_reference).and_return('users/id5') }

    it { is_expected.to eq tokens }
  end

  describe 'validate' do
    describe 'super admin' do
      it 'requires admin role' do
        user.super_admin = true
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Super admin can only be enabled for an admin'

        user.security_roles = [admin_role]
        expect(user).to be_valid

        user.super_admin = false
        user.save!

        user.super_admin = true
        expect(user).to be_valid
        user.save!
      end
    end

    it 'rejects unauthorized email addresses' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. user@foo.com user@foo.com]

      addresses.each do |address|
        user = User.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'rejects invalid email addresses' do
      addresses = ['foo @example.com', '.b ar@example.com']

      addresses.each do |address|
        user = User.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is invalid'
      end
    end

    it 'allows valid email addresses' do
      addresses = %w[joe@example.com bob@example.com sally@example.com]

      addresses.each do |address|
        user = User.new(attributes.merge(email: address))
        expect(user).to be_valid
      end
    end

    it "doesn't allow super admin on external user" do
      user = User.new(attributes.merge(external: true, super_admin: true))
      expect(user).not_to be_valid
      expect(user.errors.full_messages.to_s).to include 'is not applicable for external users'
    end
  end

  describe 'authy' do
    let(:user) { create :user, mobile_phone: phone_number }
    let(:phone_number) { '(123) 456-7111' }
    let(:new_phone_number) { '(456) 789-0123' }
    let(:authy_id) { '1234567' }
    let(:role1) { SecurityRole.find_by(name: 'User') }
    let(:role2) { admin_role }

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

    it 'updates updated_at datetime when security roles are added' do
      updated_at = user.updated_at
      user.update!(security_roles: [role1, role2])
      expect(user.updated_at).not_to eq(updated_at)
    end

    it 'updates updated_at datetime when security roles are removed' do
      user = create(:user, security_roles: [role1, role2])
      updated_at = user.updated_at
      user.update!(security_roles: [role1])
      expect(user.updated_at).not_to eq(updated_at)
    end
  end
end
