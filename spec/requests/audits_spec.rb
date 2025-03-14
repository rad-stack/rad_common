require 'rails_helper'

RSpec.describe 'Audits', type: :request do
  let(:division) { create :division }

  before { login_as user, scope: :user }

  describe 'index' do
    before { get '/rad_common/audits', params: { auditable_type: 'Division', auditable_id: division.id } }

    context 'when admin' do
      let(:user) { create :admin }

      it 'shows audits' do
        expect(response.body).to include division.name
      end
    end

    context 'when user' do
      let(:security_role) { create :security_role, delete_division: allowed }
      let(:user) { create :user, security_roles: [security_role] }

      context 'when allowed' do
        let(:allowed) { true }

        it 'shows audits' do
          expect(response.body).to include division.name
        end
      end

      context 'when not allowed' do
        let(:allowed) { false }

        it 'denies access' do
          expect(response.code).to eq '403'
        end
      end
    end
  end
end
