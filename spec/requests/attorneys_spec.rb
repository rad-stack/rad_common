require 'rails_helper'

RSpec.describe 'Attorneys' do
  let(:user) { create :admin }
  let(:attorney) { create :attorney }
  let(:invalid_attributes) { { first_name: Faker::Name.first_name, company_name: nil } }

  let(:valid_attributes) do
    { first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      company_name: Faker::Company.name,
      address_1: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip,
      phone_number: create(:phone_number),
      email: Faker::Internet.email }
  end

  before do
    allow_any_instance_of(Attorney).to receive(:bypass_address_validation?).and_return(true)
    login_as user, scope: :user
  end

  describe 'index' do
    context 'when pdf format' do
      it 'generates a pdf' do
        get "/attorneys/#{attorney.id}", params: { format: 'pdf' }

        expect(response.content_type).to eq('application/pdf')
      end
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Attorney' do
        expect {
          post '/attorneys', params: { attorney: valid_attributes }
        }.to change(Attorney, :count).by(1)
      end

      it 'redirects to the created attorney' do
        post '/attorneys', params: { attorney: valid_attributes }
        expect(response).to redirect_to(Attorney.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/attorneys', params: { attorney: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { first_name: 'bar' } }

      it 'updates the requested attorney' do
        put "/attorneys/#{attorney.to_param}", params: { attorney: new_attributes }
        attorney.reload
        expect(attorney.first_name).to eq('bar')
      end

      it 'redirects to the attorney' do
        put "/attorneys/#{attorney.to_param}", params: { attorney: valid_attributes }
        expect(response).to redirect_to(attorney)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/attorneys/#{attorney.to_param}", params: { attorney: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested attorney' do
      attorney
      expect {
        delete "/attorneys/#{attorney.to_param}",
               headers: { HTTP_REFERER: "/attorneys/#{attorney.to_param}" }
      }.to change(Attorney, :count).by(-1)
    end

    it 'redirects to the attorneys list' do
      delete "/attorneys/#{attorney.to_param}",
             headers: { HTTP_REFERER: "/attorneys/#{attorney.to_param}" }
      expect(response).to redirect_to(attorneys_url)
    end
  end
end
