require 'rails_helper'

describe "Audit search", type: :request do
  describe 'search' do
    let(:user) { create(:admin) }
    before(:each) { login_as(user, scope: :user) }

    context 'audit exists' do
      it 'loads audit page' do
        visit audit_search_users_path
        select user.class.to_s, from: "model_name"
        fill_in "record_id", with: user.id
        within(:css, '.form-inputs') { click_button "Search" }
        expect(page).to have_content("Updates for #{user.class.to_s} - #{user}")
      end

      context 'resource deleted' do
        it 'loads audit page' do
          deleted_user = create(:user)
          deleted_user.destroy
          visit audit_search_users_path
          select deleted_user.class.to_s, from: "model_name"
          fill_in "record_id", with: deleted_user.id
          within(:css, '.form-inputs') { click_button "Search" }
          expect(page).to have_content("Updates for #{deleted_user.class.to_s} - #{deleted_user.id}")
        end
      end
    end

    context 'audit does not exist' do
      it 'displays audit not found message' do
        invalid_user_id = 9999
        visit audit_search_users_path
        select user.class.to_s, from: "model_name"
        fill_in "record_id", with: invalid_user_id
        within(:css, '.form-inputs') { click_button "Search" }
        expect(page).to have_content("Audit for #{user.class.to_s} with ID of #{invalid_user_id} not found")
      end
    end
  end
end
