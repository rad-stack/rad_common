require 'rails_helper'

RSpec.describe User, type: :model do
  let(:security_role) { create :security_role }
  let(:user) { create :user, security_roles: [security_role], user_status: active_status }
  let(:active_status) { UserStatus.default_active_status.presence || create(:user_status, :active, name: 'Active') }
  let(:pending_status) { UserStatus.default_pending_status.presence || create(:user_status, :pending, name: 'Pending') }

  let(:inactive_status) do
    UserStatus.default_inactive_status.presence || create(:user_status, :inactive, name: 'Inactive')
  end

  let(:attributes) do
    { first_name: 'Example',
      last_name: 'User',
      mobile_phone: create(:phone_number, :mobile),
      email: 'user@example.com',
      password: 'cOmpl3x_p@55w0rd',
      password_confirmation: 'cOmpl3x_p@55w0rd',
      security_roles: [security_role] }
  end

  describe 'notify_user_approved', :pending_user_specs do
    let(:notification_type) { Notifications::UserWasApprovedNotification.main }
    let(:user) { create :user, security_roles: [security_role], user_status: pending_status }
    let(:admin) { create :admin, user_status: active_status }
    let(:first_mail) { ActionMailer::Base.deliveries.first }
    let(:last_mail) { ActionMailer::Base.deliveries.last }

    before do
      ActionMailer::Base.deliveries = []
      user.update! user_status: active_status, do_not_notify_approved: false, approved_by: admin
    end

    it 'notifies' do
      expect(first_mail.subject).to include 'Your Account Was Approved'
      expect(last_mail.subject).to include 'User Was Approved'
    end
  end

  describe 'auditing of associations' do
    let(:audit) { user.own_and_associated_audits.reorder('created_at DESC').first }

    before do
      allow(RadConfig).to receive(:pending_users?).and_return true
      allow_any_instance_of(described_class).to receive(:notify_user_approved).and_return(nil)
      user.update! user_status: create(:user_status, :pending)
    end

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

    it 'accepts same password only after 12 changes', :password_expirable_specs do
      13.times do |i|
        user.update(password: "Password#{i + 1}!", password_confirmation: "Password#{i + 1}!")
      end

      13.times do |i|
        expect(user.update(password: "Password#{i + 1}!", password_confirmation: "Password#{i + 1}!")).to be false
        expect(user.errors.full_messages.to_s).to include 'was used previously'
      end

      expect(user.update(password: 'cOmpl3x_p@55w0rd', password_confirmation: 'cOmpl3x_p@55w0rd')).to be true
    end
  end

  describe 'validate email address' do
    before { Company.main.update! valid_user_domains: %w[example.com rubygems.org] }

    it 'rejects unauthorized email addresses', :valid_user_domain_specs do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. user@foo.com user@foo.com]
      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'rejects invalid email addresses' do
      addresses = ['foo @example.com', '.b ar@example.com', 'com-none']

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not written in a valid format'
      end
    end

    it 'allows valid email addresses' do
      addresses = %w[joe@example.com bob@example.com sally@example.com brah@rubygems.org]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).to be_valid
      end
    end
  end

  describe 'external user', :external_user_specs do
    let(:external_role) { create :security_role, :external }

    let(:attributes) do
      { first_name: 'Example',
        last_name: 'User',
        mobile_phone: create(:phone_number, :mobile),
        password: 'cH@ngem3',
        password_confirmation: 'cH@ngem3',
        user_status: active_status,
        external: true,
        security_roles: [external_role] }
    end

    before { Company.main.update! valid_user_domains: %w[example.com rubygems.org] }

    it 'rejects unauthorized email addresses', :valid_user_domain_specs do
      addresses = %w[user@example.com user@rubygems.org]
      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address))
        expect(user).not_to be_valid
        expect(user.errors.full_messages.to_s).to include 'Email is not authorized for this application'
      end
    end

    it 'allows unauthorized email addresses for inactive users', :external_user_specs do
      addresses = %w[user@example.com user@rubygems.org]

      addresses.each do |address|
        user = described_class.new(attributes.merge(email: address, user_status: inactive_status))
        expect(user).to be_valid
      end
    end

    it 'allows valid email addresses', :external_user_specs do
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

  describe 'password expirable', :password_expirable_specs do
    it 'has a password that expires after 90 days' do
      expect(user.need_change_password?).to be(false)
      Timecop.travel(91.days.from_now) { expect(user.need_change_password?).to be(true) }
    end
  end

  describe 'exiprable', :user_expirable_specs do
    it 'expires after 90 days' do
      user.update!(last_activity_at: Time.current)
      expect(user.expired?).to be(false)

      Timecop.travel(91.days.from_now) { expect(user.expired?).to be(true) }
    end

    it 'expires for a new user without activity' do
      expect(user.expired?).to be(false)

      Timecop.travel(91.days.from_now) { expect(user.expired?).to be(true) }
    end
  end

  describe 'Email Changed', :shared_database_specs do
    subject { ActionMailer::Base.deliveries.map(&:subject).sort }

    let!(:user) { create :user }

    before { user.update!(email: 'foobar@example.com') }

    it { is_expected.to eq(['Confirmation instructions', 'Email Changed']) }
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

  describe 'avatar' do
    let(:user) { create :user, :with_avatar }

    it 'uploads' do
      expect(user).to be_persisted
      expect(user.avatar.attached?).to be true
    end
  end

  def assert_password_with_name(first_name, last_name, password, valid)
    user = build :user,
                 first_name: first_name,
                 last_name: last_name,
                 password: password,
                 password_confirmation: password

    user.valid?

    if valid
      expect(user.errors.full_messages.to_s).not_to include 'Password cannot contain your name'
    else
      expect(user.errors.full_messages.to_s).to include 'Password cannot contain your name'
    end
  end
end
