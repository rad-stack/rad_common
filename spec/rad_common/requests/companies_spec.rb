require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:user) { create :admin }
  let(:company) { Company.main }
  let(:valid_attributes) { { name: 'foo' } }
  let(:invalid_attributes) { { name: nil } }

  before { login_as user, scope: :user }

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { name: 'bar' } }

      it 'updates the requested company' do
        put '/rad_common/company/update', params: { company: new_attributes }
        company.reload
        expect(company.name).to eq('bar')
      end

      it 'redirects to the company' do
        put '/rad_common/company/update', params: { company: new_attributes }
        expect(response).to redirect_to('/rad_common/company')
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put '/rad_common/company/update', params: { company: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end
end
