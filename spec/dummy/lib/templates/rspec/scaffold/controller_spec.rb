require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, type: :controller do
  let(:user) { create :admin }
  let(:<%= file_name %>) { create :<%= file_name %> }

  before do
    sign_in user
  end

  let(:valid_attributes) do
    { <%= attributes_names.map { |name| "#{name}: 'foo'" }.join(', ') %> }
  end

  let(:invalid_attributes) do
    { <%= attributes_names.first %>: nil }
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a super new new new <%= class_name %>' do
        expect do
          post :create, params: { <%= ns_file_name %>: valid_attributes }
        end.to change(<%= class_name %>, :count).by(1)
      end

      it 'redirects to the created <%= ns_file_name %>' do
        post :create, params: { <%= ns_file_name %>: valid_attributes }
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    describe 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { <%= ns_file_name %>: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        { <%= attributes_names.first %>: 'bar' }
      end

      it 'updates the requested <%= ns_file_name %>' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: new_attributes }
        <%= file_name %>.reload
        expect(<%= file_name %>.<%= attributes_names.first %>).to eq('bar')
      end

      it 'redirects to the <%= ns_file_name %>' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: valid_attributes }
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe 'with invalid params' do
      it 're-renders the edit template' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @request.env['HTTP_REFERER'] =<%= singular_table_name %>_path(<%= singular_table_name %>)
    end

    it 'destroys the requested <%= ns_file_name %>' do
      <%= file_name %>
      expect do
        delete :destroy, params: { id: <%= file_name %>.to_param }
      end.to change(<%= class_name %>, :count).by(-1)
    end

    it 'redirects to the <%= table_name %> list' do
      delete :destroy, params: { id: <%= file_name %>.to_param }
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end
end
<% end -%>
