require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe '<%= class_name.pluralize %>', type: :request do
  let(:user) { create :admin }
  let(:<%= file_name %>) { create :<%= file_name %> }
  let(:valid_attributes) { { foo: 'foo', bar: 'bar' } }
  let(:invalid_attributes) { { foo: nil } }

  before { login_as user, scope: :user }

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new <%= class_name %>' do
        expect {
          post '/<%= table_name %>', params: { <%= file_name.singularize %>: valid_attributes }
        }.to change(<%= class_name %>, :count).by(1)
      end

      it 'redirects to the created <%= file_name.singularize %>' do
        post '/<%= table_name %>', params: { <%= file_name.singularize %>: valid_attributes }
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/<%= table_name %>', params: { <%= file_name.singularize %>: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { { foo: 'bar' } }

      it 'updates the requested <%= file_name.singularize %>' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: { <%= file_name.singularize %>: new_attributes }
        <%= file_name %>.reload
        expect(<%= file_name %>.foo).to eq('bar')
      end

      it 'redirects to the <%= file_name.singularize %>' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: { <%= file_name.singularize %>: valid_attributes }
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: { <%= file_name.singularize %>: invalid_attributes }
        expect(response.body).to include 'Please review the problems below'
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested <%= file_name.singularize %>' do
      <%= file_name %>
      expect {
        delete "/<%= table_name %>/#{<%= file_name %>.to_param}",
               headers: { HTTP_REFERER: "/<%= table_name %>/#{<%= file_name %>.to_param}" }
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it 'redirects to the <%= table_name %> list' do
      delete "/<%= table_name %>/#{<%= file_name %>.to_param}",
             headers: { HTTP_REFERER: "/<%= table_name %>/#{<%= file_name %>.to_param}" }
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end
end
<% end -%>
