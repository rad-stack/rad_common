require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe '<%= class_name.pluralize %>', type: :request do
  let(:user) { create :admin }
  let(:<%= file_name %>) { create :<%= file_name %> }

  before do
    sign_in user
  end

  let(:valid_attributes) do
    { foo: 'bar', bar: 'foo' }
  end

  let(:invalid_attributes) do
    { foo: nil }
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new <%= class_name %>' do
        expect do
          post '/<%= table_name %>', params: {<%= file_name.singularize %>: valid_attributes }
        end.to change(<%= class_name %>, :count).by(1)
      end

      it 'redirects to the created<%= file_name.singularize %>' do
        post '/<%= table_name %>', params: {<%= file_name.singularize %>: valid_attributes }
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post '/<%= table_name %>', params: {<%= file_name.singularize %>: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { foo: 'bar' }
      end

      it 'updates the requested<%= file_name.singularize %>' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: {<%= file_name.singularize %>: new_attributes }
        <%= file_name %>.reload
        expect(<%= file_name %>.foo).to eq('bar')
      end

      it 'redirects to the<%= file_name.singularize %>' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: {<%= file_name.singularize %>: valid_attributes }
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put "/<%= table_name %>/#{<%= file_name %>.to_param}", params: { <%= file_name.singularize %>: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested<%= file_name.singularize %>' do
      <%= file_name %>
      expect do
        delete "/<%= table_name %>/#{<%= file_name %>.to_param}", headers: { HTTP_REFERER: "/<%= table_name %>/#{<%= file_name %>.to_param}"}
      end.to change(<%= class_name %>, :count).by(-1)
    end

    it 'redirects to the <%= table_name %> list' do
      delete "/<%= table_name %>/#{<%= file_name %>.to_param}", headers: { HTTP_REFERER: "/<%= table_name %>/#{<%= file_name %>.to_param}"}
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end
end
<% end -%>
