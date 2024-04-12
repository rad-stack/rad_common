require 'rails_helper'

describe GlobalValidation, type: :service do
  let(:global_validity) { described_class.new }
  let!(:admin_security_role) { admin.security_roles.first }
  let(:company) { Company.main }
  let(:admin) { create :admin }
  let(:url) { "http://localhost:3000/security_roles/#{admin_security_role.id}" }
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:email_body_text) { last_email.body.parts.first.body.raw_source }
  let(:email_body_html) { last_email.body.parts.second.body.raw_source }

  before do
    Notifications::InvalidDataWasFoundNotification.main
    ActionMailer::Base.deliveries.clear
  end

  # TODO: add tests for override model feature

  describe 'models_to_check' do
    subject { global_validity.send(:models_to_check).map(&:to_s) }

    let(:models) do
      %w[Attorney Category Client Company ContactLog ContactLogAttachment ContactLogRecipient
         Division Duplicate Notification NotificationSecurityRole NotificationSetting
         NotificationType SavedSearchFilter SecurityRole Status SystemMessage User
         UserClient UserSecurityRole UserStatus]
    end

    it { is_expected.to eq models }
  end

  context 'with valid data' do
    let(:global_validity_check) { global_validity.run }

    it 'company validity_checked_at should update' do
      global_validity_check
      expect(company.reload.validity_checked_at).not_to be_nil
    end

    it 'does not send an email' do
      global_validity_check
      expect(last_email).to be_nil
    end
  end

  context 'with invalid data' do
    before do
      admin_security_role.create_division = false
      admin_security_role.save!(validate: false)
    end

    context 'without admin' do
      subject(:result) { global_validity.run }

      before { admin.update!(security_roles: [create(:security_role)]) }

      it 'raises an exception' do
        expect {
          result
        }.to raise_error(RuntimeError, 'no users to notify: Notifications::InvalidDataWasFoundNotification')
      end
    end

    describe '.run' do
      before do
        allow(RadConfig).to receive(:global_validity_supress!)
          .and_return([{ class: 'SomeSuppression', messages: ['Anything'] }])
      end

      it 'sends an email to admins when data is invalid' do
        global_validity.run

        expect(last_email.subject).to eq("Invalid data in #{RadConfig.app_name!}")
        expect(last_email.to).to eq([admin.email])
        expect(email_body_text).to include('requires all permissions to be true')
        expect(email_body_html).to include('requires all permissions to be true')
        expect(email_body_html).to include('There is 1 invalid record')
        expect(email_body_html).to include("Security Role #{admin_security_role.id} (#{admin_security_role})")
        expect(email_body_html).to include(url)
      end
    end

    describe 'with specific queries' do
      context 'when table was ignored, but specific query hits it' do
        let(:specific_query) { -> { SecurityRole.where(id: admin_security_role.id) } }

        before do
          allow(RadConfig).to receive(:global_validity_exclude!).and_return ['SecurityRole']
          allow(RadConfig).to receive(:global_validity_include!).and_return [specific_query]
        end

        it 'sends an email to current user when data is invalid' do
          global_validity.run

          expect(last_email.subject).to eq("Invalid data in #{RadConfig.app_name!}")
          expect(last_email.to).to eq([admin.email])
          expect(email_body_text).to include('requires all permissions to be true')
          expect(email_body_html).to include('requires all permissions to be true')
          expect(email_body_html).to include('There is 1 invalid record')
          expect(email_body_html).to include(url)
        end
      end
    end
  end
end
