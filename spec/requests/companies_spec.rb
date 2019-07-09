require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:user) { create :admin }
  let(:company) { Company.main }

  before do
    login_as(user, scope: :user)
  end

  let(:valid_attributes) do
    { name: 'foo' }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { name: 'bar' }
      end

      it 'updates the requested company' do
        put "/companies/#{company.id}", params: { company: new_attributes }
        company.reload
        expect(company.name).to eq('bar')
      end

      it 'redirects to the company' do
        put "/companies/#{company.id}", params: { company: new_attributes }
        expect(response).to redirect_to(company)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/companies/#{company.id}", params: { company: invalid_attributes }
        expect(response).not_to redirect_to(company)
      end
    end
  end
end
