require 'rails_helper'

RSpec.describe 'Audits', type: :request do
  let(:admin) { create :admin }
  let(:escaped_user_name) { ERB::Util.html_escape(search_user.to_s) }
  let!(:search_user) { create :user }

  before { login_as admin, scope: :user }

  describe 'index' do
    it 'shows audits' do
      get '/rad_common/audits', params: { search: { auditable_type: 'User' } }
      expect(response.body).to include escaped_user_name
    end
  end
end
