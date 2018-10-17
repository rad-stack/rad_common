require 'rails_helper'

describe 'Audit search', type: :request do
  describe 'search' do
    let(:user) { create(:admin) }

    before { login_as(user, scope: :user) }

    context 'audit exists' do
      it 'loads audit page' do
        visit audit_search_users_path
        select user.class.to_s, from: 'record-search'
        fill_in 'record_id', with: user.id
        within(:css, '.form-inputs#record-search') { click_button 'Search' }
        expect(page).to have_content("Updates for #{user.class} - #{user}")
      end

      context 'resource deleted' do
        it 'loads audit page' do
          deleted_role = create(:security_role, read_audit: true)
          deleted_role.destroy
          visit audit_search_users_path
          select deleted_role.class.to_s, from: 'record-search'
          fill_in 'record_id', with: deleted_role.id
          within(:css, '.form-inputs#record-search') { click_button 'Search' }
          expect(page).to have_content("Updates for #{deleted_role.class} - #{deleted_role.id}")
        end
      end
    end

    context 'audit does not exist' do
      it 'displays audit not found message' do
        invalid_user_id = 9999
        visit audit_search_users_path
        select user.class.to_s, from: 'record-search'
        fill_in 'record_id', with: invalid_user_id
        within(:css, '.form-inputs#record-search') { click_button 'Search' }
        expect(page).to have_content("Audit for #{user.class} with ID of #{invalid_user_id} not found")
      end
    end
  end
end
