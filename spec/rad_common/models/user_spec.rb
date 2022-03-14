require 'rails_helper'

RSpec.describe User, type: :model do
  let(:security_role) { create :security_role }
  let(:user) { create :user, security_roles: [security_role] }
  let(:active_status) { create :user_status, :active }
  let(:inactive_status) { create :user_status, :inactive }

  let(:attributes) do
    { first_name: 'Example',
      last_name: 'User',
      authy_enabled: false,
      mobile_phone: create(:phone_number, :mobile),
      email: 'user@example.com',
      password: 'cOmpl3x_p@55w0rd',
      password_confirmation: 'cOmpl3x_p@55w0rd' }
  end

  describe 'notify_user_approved' do
    let(:notification_type) { create :user_was_approved_notification }
    let(:admin) { create :admin }
    let(:user) { create :user, security_roles: [security_role], user_status: inactive_status }
    let(:first_mail) { ActionMailer::Base.deliveries.first }
    let(:last_mail) { ActionMailer::Base.deliveries.last }

    before do
      create :notification_security_role,
             notification_type: notification_type,
             security_role: admin.security_roles.first

      ActionMailer::Base.deliveries = []
      user.update! user_status: active_status, do_not_notify_approved: false
    end

    it 'notifies' do
      expect(first_mail.subject).to include 'Your Account Was Approved'
      expect(last_mail.subject).to include 'User Was Approved'
    end
  end

  describe 'auditing of associations' do
    let(:audit) { user.own_and_associated_audits.reorder('created_at DESC').first }

    context 'with create' do
      before do
        user.update!(security_roles: [])
        user.update!(security_roles: [security_role])
      end

      it 'audits' do
        expect(audit.auditable_type).to eq 'UserSecurityRole'
        expect(audit.associated).to eq user
        expect(audit.action).to eq 'create'
      end
    end

    context 'with destroy' do
      before do
        user.update!(security_roles: [])
        user.update!(security_roles: [security_role])
        user.update!(security_roles: [])
      end

      it 'audits' do
        expect(audit.auditable_type).to eq 'UserSecurityRole'
        expect(audit.associated).to eq user
        expect(audit.action).to eq 'destroy'
      end
    end
  end

  describe 'password validations' do
    it 'requires a password' do
      expect(described_class.new(attributes.merge(password: '', password_confirmation: ''))).not_to be_valid
    end

    it 'requires a matching password confirmation' do
      expect(described_class.new(attributes.merge(password_confirmation: 'invalid'))).not_to be_valid
    end

    it 'rejects short passwords' do
      short = 'Abef2!'
      hash = attributes.merge(password: short, password_confirmation: short)
      expect(described_class.new(hash)).not_to be_valid
    end

    it 'accepts normal length passwords' do
      normal = 'Abedff2!'
      hash = attributes.merge(password: normal, password_confirmation: normal)
      expect(described_class.new(hash)).to be_valid
    end

    it 'rejects passwords that contain name' do
      assert_password_with_name 'John', 'Smith', 'John1!', false
      assert_password_with_name 'John ', 'Smith', 'John1!', false
      assert_password_with_name 'John', 'Smith', 'JOHN1!', false
      assert_password_with_name 'John', 'Smith', 'Smith1!', false
      assert_password_with_name 'John', 'Smith', 'SMITH1!', false
      assert_password_with_name 'John', 'Smith', 'jOhn1!', false
      assert_password_with_name 'John', 'Smith', 'JOHNSMITH1!', false
      assert_password_with_name 'John', 'Smith', 'J0HNSM1TH1!', true
    end

    it 'rejects simple passwords' do
      if Devise.mappings[:user].secure_validatable?
        expect(build(:user, password: 'password', password_confirmation: 'password')).not_to be_valid
        expect(build(:user, password: 'Password', password_confirmation: 'Password')).not_to be_valid
        expect(build(:user, password: 'Password55757', password_confirmation: 'Password55757')).not_to be_valid
        expect(build(:user, password: 'Password!!!', password_confirmation: 'Password!!!')).not_to be_valid
        expect(build(:user, password: 'Password!!!4646', password_confirmation: 'Password!!!4646')).to be_valid
      end
    end

    it 'accepts same password only after 12 changes' do
      if Devise.mappings[:user].password_expirable?
        13.times do |i|
          user.update(password: "Password#{i + 1}!", password_confirmation: "Password#{i + 1}!")
        end

        13.times do |i|
          expect(user.update(password: "Password#{i + 1}!", password_confirmation: "Password#{i + 1}!")).to eq false
          expect(user.errors.full_messages.to_s).to include 'was used previously'
        end

        expect(user.update(password: 'cOmpl3x_p@55w0rd', password_confirmation: 'cOmpl3x_p@55w0rd')).to eq true
      end
    end
  end

  describe 'validate email address' do
    before { Company.main.update! valid_user_domains: %w[example.com radicalbear.com] }

    it 'rejects unauthorized email addresses' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. user@foo.com user@foo.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'rejects invalid email addresses' do
      addresses = ['foo @example.com', '.b ar@example.com', 'com@none']

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include(
          'Email is not written in a valid format. Email cannot have capital letters, '\
          'domain must be less than 62 characters and does not allow special characters.'
        )
      end
    end

    it 'allows valid email addresses' do
      addresses = %w[joe@example.com bob@example.com sally@example.com brah@radicalbear.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).to be_valid
      end
    end
  end

  describe 'external user' do
    let(:attributes) do
      { first_name: 'Example',
        last_name: 'User',
        authy_enabled: false,
        mobile_phone: create(:phone_number, :mobile),
        password: 'cH@ngem3',
        password_confirmation: 'cH@ngem3',
        user_status: active_status,
        external: true }
    end

    before { Company.main.update! valid_user_domains: %w[example.com radicalbear.com] }

    it 'rejects unauthorized email addresses' do
      addresses = %w[user@example.com user@radicalbear.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'allows unauthorized email addresses for inactive users', external_user_specs: true do
      addresses = %w[user@example.com user@radicalbear.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address, user_status: inactive_status))
        expect(user).to be_valid
      end
    end

    it 'allows valid email addresses', external_user_specs: true do
      addresses = %w[joe@abc.com bob@abc.com sally@abc.com]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
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

  describe 'password expirable' do
    it 'has a password that expires after 90 days' do
      if Devise.mappings[:user].password_expirable?
        expect(user.need_change_password?).to eq(false)
        Timecop.travel(91.days.from_now) { expect(user.need_change_password?).to eq(true) }
      end
    end
  end

  describe 'exiprable' do
    it 'expires after 90 days' do
      if Devise.mappings[:user].expirable?
        user.update!(last_activity_at: Time.current)
        expect(user.expired?).to eq(false)

        Timecop.travel(91.days.from_now) { expect(user.expired?).to eq(true) }
      end
    end
  end

  describe 'Email Changed' do
    subject { ActionMailer::Base.deliveries[ActionMailer::Base.deliveries.length - 2].subject }

    let!(:user) { create :user }

    before { user.update!(email: 'foobar@example.com') }

    it { is_expected.to eq('Email Changed') }
  end

  describe 'Password Changed' do
    subject { ActionMailer::Base.deliveries.last.subject }

    let!(:user) { create :user }

    before { user.update!(password: 'NewPassword2!', password_confirmation: 'NewPassword2!') }

    it { is_expected.to eq 'Password Changed' }
  end

  describe 'security roles' do
    let(:admin_role) { create :security_role, :admin }
    let(:role_1) { create :security_role }
    let(:role_2) { admin_role }

    it 'updates updated_at datetime when security roles are added' do
      updated_at = user.updated_at
      user.update!(security_roles: [role_1, role_2])
      expect(user.updated_at).not_to eq(updated_at)
    end

    it 'updates updated_at datetime when security roles are removed' do
      user = create :user
      updated_at = user.updated_at
      user.update!(security_roles: [role_2])
      expect(user.updated_at).not_to eq(updated_at)
    end
  end

  describe 'authy', authy_specs: true do
    let(:user) { create :user, mobile_phone: phone_number }
    let(:phone_number) { create :phone_number, :mobile }
    let(:new_phone_number) { create :phone_number, :mobile }

    it 'creates and updates the user on authy', :vcr do
      expect(user.authy_id).to be_nil
      user.update!(authy_enabled: true)
      expect(user.authy_id).not_to be_nil
    end

    it 'returns a failure message if authy doesnt update' do
      result = double(:response, ok?: false, message: 'mocked message')

      allow(Authy::API).to receive(:register_user).and_return(result)

      user.authy_enabled = true
      user.mobile_phone = new_phone_number
      user.save
      expect(user.errors.full_messages.to_s).to include('Could not register authy user')
    end

    it 'deletes authy user if mobile phone wiped out' do
      unless RadCommon::AppInfo.new.user_requires_mobile_phone?
        user.update!(authy_enabled: false, mobile_phone: nil)
        expect(user.reload.authy_id).to be_blank
      end
    end

    it "doesn't allow invalid email", :vcr do
      user = build :user, mobile_phone: phone_number, email: 'foo@', authy_enabled: true
      user.save
      expect(user.errors.full_messages.to_s).to include('Could not register authy user')
    end
  end

  describe 'avatar' do
    let(:user) { create :user, :with_avatar }

    it 'uploads' do
      expect(user).to be_persisted
      expect(user.avatar.attached?).to be true
    end
  end

  def assert_password_with_name(first_name, last_name, password, valid)
    user = build(:user,
                 first_name: first_name,
                 last_name: last_name,
                 password: password,
                 password_confirmation: password)

    user.valid?

    if valid
      expect(user.errors.full_messages.to_s).not_to include 'Password cannot contain your name'
    else
      expect(user.errors.full_messages.to_s).to include 'Password cannot contain your name'
    end
  end
end
