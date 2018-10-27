require 'rails_helper'

describe RadCommon::GlobalValidity do
  let(:admin_security_role) { SecurityRole.find_by(name: 'Admin') }
  let(:company) { Company.main }
  let!(:super_admin) { create :super_admin }
  let(:url) { "http://example.com/security_roles/#{admin_security_role.id}" }
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let(:email_body_text) { last_email.body.parts.first.body.raw_source }
  let(:email_body_html) { last_email.body.parts.second.body.raw_source }

  before { ActionMailer::Base.deliveries.clear }

  context 'with valid data' do
    let(:global_validity_check) { described_class.check_all_companies }

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

    describe '.check_all_companies' do
      before do
        Rails.configuration.global_validity_supress = [{ class: 'SomeSuppression', messages: ['Anything'] }]
      end

      it 'sends an email to super admins when data is invalid' do
        described_class.check_all_companies

        expect(last_email.subject).to eq("Invalid data in #{I18n.t(:app_name)}")
        expect(last_email.to).to eq([super_admin.email])
        expect(email_body_text).to include("requires all permissions to be true")
        expect(email_body_html).to include('requires all permissions to be true')
        expect(email_body_html).to include('There is 1 invalid record')
        expect(email_body_html).to include(url)
      end
    end

    describe 'with specific queries' do
      context 'table was ignored, but specific query hits it' do
        let(:specific_query) { -> { SecurityRole.where(name: 'Admin') } }

        before do
          Rails.configuration.global_validity_exclude = [SecurityRole]
          Rails.configuration.global_validity_include = [specific_query]
        end

        it 'sends an email to current user when data is invalid' do
          described_class.check_all_companies

          expect(last_email.subject).to eq("Invalid data in #{I18n.t(:app_name)}")
          expect(last_email.to).to eq([super_admin.email])
          expect(email_body_text).to include("requires all permissions to be true")
          expect(email_body_html).to include('requires all permissions to be true')
          expect(email_body_html).to include('There is 1 invalid record')
          expect(email_body_html).to include(url)
        end
      end
    end

    describe 'with destroyed data', regression: true do
      it 'does not include destroyed record data' do
        expect_any_instance_of(SecurityRole).to receive(:persisted?).and_return(false)
        described_class.check_all_companies

        expect(last_email.to).to eq([super_admin.email])
        expect(email_body_html).not_to include('requires all permissions to be true')
      end
    end
  end
end
