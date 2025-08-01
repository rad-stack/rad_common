require 'rails_helper'

describe 'Audits' do
  let(:admin) { create :admin }
  let(:contact_log_recipient) { create :contact_log_recipient }

  before { login_as admin, scope: :user }

  describe 'index' do
    it 'shows audits for objects without show pages' do
      open_status = create :status, name: 'Open'

      Audited.audit_class.as_user(admin) do
        open_status.update!(name: 'Foo')
      end

      visit "/audits/?#{{ search: { user_id: admin.id } }.to_query}"
      expect(page).to have_content 'Status - Foo'
    end

    it 'shows enum value in human readable form' do
      contact_log_recipient.update! sms_status: :queued

      visit "/contact_log_recipients/#{contact_log_recipient.id}"
      click_link_or_button 'Audit History'

      expect(page).to have_content 'Audits for'
      expect(page).to have_content '(2)'
      expect(page).to have_content 'Queued'
    end

    describe 'show_routes' do
      before { RadCommon::ApplicationHelper.instance_variable_set(:@show_routes, nil) }

      it 'is cached at startup and runs only once' do
        expect_any_instance_of(RadCommon::AppInfo).to receive(:show_routes).exactly(1).time.and_call_original
        admin.update!(first_name: 'John')

        visit audits_path
        expect(page).to have_content('Changed First Name')
        expect(page).to have_content('Changed Last Sign In')
      end
    end
  end
end
