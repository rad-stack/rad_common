require 'rails_helper'

RSpec.describe 'Audits', type: :request do
  let(:escaped_user_name) { ERB::Util.html_escape(search_user.to_s) }
  let!(:search_user) { create :user }

  before { login_as user, scope: :user }

  describe 'index' do
    before { get '/audits', params: { search: { auditable_type: 'User' } } }

    context 'when admin' do
      let(:user) { create :admin }

      it 'shows audits' do
        expect(response.body).to include escaped_user_name
      end
    end

    context 'when user' do
      let(:user) { create :user }

      it 'denies access' do
        expect(response).to have_http_status :forbidden
      end
    end
  end
end
