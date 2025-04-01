require 'rails_helper'

describe 'Audits', type: :system do
  let(:admin) { create :admin }

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
  end
end
