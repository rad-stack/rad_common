require 'rails_helper'

describe RadCommon::GlobalValidity do
  let(:admin_security_role) { SecurityRole.find_by_name('Admin') }
  let(:company) { Company.main }
  let!(:super_admin) { create :super_admin }
  let(:url) { "http://example.com/security_roles/#{admin_security_role.id}" }

  describe '.check_all_companies' do
    context 'there is invalid data' do
      before do
        Rails.configuration.global_validity_supress = [{class: 'SomeSuppression', messages: ['Anything']}]
        admin_security_role.update_column(:create_division, false)
      end

      it 'sends an email to super admins when data is invalid' do
        described_class.check_all_companies
        last_email = ActionMailer::Base.deliveries.last
        expect(last_email.subject).to eq("Invalid data in #{I18n::t(:app_name)}")

        expect(last_email.to).to eq([super_admin.email])
        email_body_text = last_email.body.parts.first.body.raw_source
        expect(email_body_text).to include("requires all permissions to be true\n\n")
        email_body_html = last_email.body.parts.second.body.raw_source
        expect(email_body_html).to include("requires all permissions to be true")
        expect(email_body_html).to include(url)
      end
    end

    context 'there is only valid data' do
      before { ActionMailer::Base.deliveries.clear }

      let(:global_validity_check) { described_class.check_all_companies }

      it 'company validity_checked_at should update' do
        global_validity_check
        expect(company.reload.validity_checked_at).to_not be_nil
      end

      it 'does not send an email' do
        global_validity_check
        last_email = ActionMailer::Base.deliveries.last
        expect(last_email).to be_nil
      end
    end
  end

  describe 'with specific queries' do
    context 'table was ignored, but specific query hits it' do
      let(:specific_query) { lambda { SecurityRole.where(name: 'Admin') } }
      before do
        Rails.configuration.global_validity_exclude = [SecurityRole]
        Rails.configuration.global_validity_include = [specific_query]
      end

      context 'invalid data' do
        before { admin_security_role.update_column(:create_division, false) }

        it 'sends an email to current user when data is invalid' do
          described_class.check_all_companies
          last_email = ActionMailer::Base.deliveries.last
          expect(last_email.subject).to eq("Invalid data in #{I18n::t(:app_name)}")

          expect(last_email.to).to eq([super_admin.email])
          email_body_text = last_email.body.parts.first.body.raw_source
          expect(email_body_text).to include("requires all permissions to be true\n\n")
          email_body_html = last_email.body.parts.second.body.raw_source
          expect(email_body_html).to include("requires all permissions to be true")
          expect(email_body_html).to include(url)
        end
      end
    end
  end

  describe 'with destroyed data', regression: true do
    before { admin_security_role.update_column(:create_division, false) }
    it 'does not include destroyed record data' do
      expect_any_instance_of(SecurityRole).to receive(:persisted?).and_return(false)
      described_class.check_all_companies
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.to).to eq([super_admin.email])
      email_body_html = last_email.body.parts.second.body.raw_source
      expect(email_body_html).to_not include("requires all permissions to be true")
    end
  end
end
