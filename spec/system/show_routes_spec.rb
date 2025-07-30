require 'rails_helper'

RSpec.describe 'Show Routes' do
  let(:admin) { create :admin }

  before { login_as admin, scope: :user }

  context 'with caching' do
    before do
      RadCommon::ApplicationHelper.instance_variable_set(:@show_routes, nil)
    end

    it 'only runs show routes method once' do
      expect_any_instance_of(RadCommon::AppInfo).to receive(:show_routes).exactly(1).time.and_call_original
      admin.update!(first_name: 'John')

      visit audits_path
      expect(page).to have_content('Changed First Name')
      expect(page).to have_content('Changed Last Sign In')
    end
  end
end
