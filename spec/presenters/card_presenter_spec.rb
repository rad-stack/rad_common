require 'rails_helper'

describe CardPresenter do
  let(:view_context) { double(:view_context) }
  let(:local_assigns) { {} }
  let(:card_presenter) { described_class.new(view_context, local_assigns) }

  describe '#controller_name' do
    let(:controller_name) { 'Foo' }

    before do
      allow(view_context).to receive(:controller_name).and_return(controller_name)
    end

    context 'with a standard contoller name' do
      it 'returns the controller name' do
        expect(card_presenter.controller_name).to eq(controller_name)
      end
    end

    context 'with a supplied controller name' do
      let(:special_controller_name) { 'admin_users' }
      let(:local_assigns) { { controller_name: special_controller_name } }

      it 'returns the special controller name' do
        expect(card_presenter.controller_name).to eq(special_controller_name)
      end
    end
  end

  describe '#new_url' do
    let(:controller_name) { 'something' }

    before do
      allow(view_context).to receive(:controller_name).and_return(controller_name)
    end

    context 'without new_url param' do
      it 'creates the new url from the controller name' do
        expect(card_presenter.new_url).to eq("/#{controller_name}/new")
      end
    end

    context 'with new_url param' do
      let(:new_url) { '/something_else/new' }
      let(:local_assigns) { { new_url: new_url } }

      it 'uses the supplied url instead' do
        expect(card_presenter.new_url).to eq(new_url)
      end
    end
  end

  describe '#edit_url' do
    let(:id) { rand(1..10) }
    let(:controller_name) { 'a_controller' }

    before do
      allow(view_context).to receive(:controller_name).and_return(controller_name)
      allow(view_context).to receive(:params).and_return(id: id)
    end

    context 'without edit_url param' do
      it 'creates the edit url from the controller name' do
        expect(card_presenter.edit_url).to eq("/#{controller_name}/#{id}/edit")
      end
    end

    context 'with edit_url param' do
      let(:edit_url) { "/different_controller/#{id}/edit" }
      let(:local_assigns) { { edit_url: edit_url  } }

      it 'uses the supplied url instead' do
        expect(card_presenter.edit_url).to eq(edit_url)
      end
    end
  end

  describe '#klass' do
    let(:controller_name) { 'a_controller' }

    before do
      allow(view_context).to receive(:controller_name).and_return(controller_name)
      allow(controller_name).to receive(:classify).and_return('Class')
    end

    it 'returns something if not custom' do
      allow(card_presenter).to receive(:custom?).and_return(false)
      expect(card_presenter.klass).not_to be_nil
    end

    it 'returns nil if custom' do
      allow(card_presenter).to receive(:custom?).and_return(true)
      expect(card_presenter.klass).to be_nil
    end
  end

  describe '#instance' do
    let(:controller) { 'controller' }
    let(:controller_name) { 'a_controller' }
    let(:klass) { 'Class' }

    before do
      allow(view_context).to receive(:controller).and_return(controller)
      allow(controller).to receive(:instance_variable_get).and_return('something')

      allow(view_context).to receive(:controller_name).and_return(controller_name)
      allow(controller_name).to receive(:classify).and_return(klass)
      allow(klass).to receive(:underscore).and_return('whatever')
    end

    it 'returns something if not custom' do
      allow(card_presenter).to receive(:custom?).and_return(false)
      expect(card_presenter.instance).not_to be_nil
    end

    it 'returns nil if custom' do
      allow(card_presenter).to receive(:custom?).and_return(true)
      expect(card_presenter.instance).to be_nil
    end
  end

  describe '#instance_label' do
    let(:label) { 'Foo' }

    context 'with custom' do
      before do
        allow(card_presenter).to receive(:custom?).and_return(true)
      end

      it 'returns nil' do
        expect(card_presenter.instance_label).to be_nil
      end
    end

    context 'without custom' do
      before do
        allow(card_presenter).to receive(:custom?).and_return(false)
      end

      it 'defaults to return #to_s' do
        allow(card_presenter).to receive(:instance).and_return(double(:instance, to_s: label))
        expect(card_presenter.instance_label).to eq(label)
      end
    end
  end

  describe '#custom?' do
    it 'true if custom' do
      allow(card_presenter).to receive(:action_name).and_return('custom')
      expect(card_presenter).to be_custom
    end

    it 'false if custom' do
      allow(card_presenter).to receive(:action_name).and_return('not custom')
      expect(card_presenter).not_to be_custom
    end
  end

  describe '#action_name' do
    let(:local_assigns) { {} }

    it 'returns params action' do
      allow(card_presenter).to receive(:params).and_return({})
      card_presenter.action_name
    end
  end

  describe '#delete_confirmation' do
    context 'when not specified' do
      it "defaults to 'Are You Sure?'" do
        expect(card_presenter.delete_confirmation).to eq('Are you sure?')
      end
    end

    context 'when specified' do
      let(:confirmation_text) { 'Test Value' }
      let(:local_assigns) { { delete_confirmation: confirmation_text } }

      it 'returns specified value' do
        expect(card_presenter.delete_confirmation).to eq(confirmation_text)
      end
    end
  end

  describe '#additional_actions' do
    let(:local_assigns) { {} }

    it 'returns an empty array' do
      expect(card_presenter.additional_actions).to eq([])
    end
  end

  shared_examples 'local_assigns has key' do
    let(:value) { 'Foobar' }
    describe 'local assigns has method key' do
      let(:local_assigns) { { method => value } }

      it 'returns local assigns value' do
        expect(card_presenter.send(method)).to eq(value)
      end
    end
  end

  shared_examples 'empty local_assigns' do
    describe 'local assigns is empty' do
      let(:local_assigns) { {} }

      it 'returns nil' do
        expect(card_presenter.send(method)).to be_falsy
      end
    end
  end

  it_behaves_like('local_assigns has key') { let(:method) { :action_name } }
  it_behaves_like('local_assigns has key') { let(:method) { :additional_actions } }
  it_behaves_like('local_assigns has key') { let(:method) { :title } }
  it_behaves_like('local_assigns has key') { let(:method) { :icon } }
  it_behaves_like('local_assigns has key') { let(:method) { :no_new_button } }
  it_behaves_like('local_assigns has key') { let(:method) { :no_edit_button } }
  it_behaves_like('local_assigns has key') { let(:method) { :no_delete_button } }
  it_behaves_like('local_assigns has key') { let(:method) { :no_index_button } }
  it_behaves_like('local_assigns has key') { let(:method) { :no_show_link } }

  it_behaves_like('empty local_assigns') { let(:method) { :title } }
  it_behaves_like('empty local_assigns') { let(:method) { :icon } }
  it_behaves_like('empty local_assigns') { let(:method) { :no_new_button } }
  it_behaves_like('empty local_assigns') { let(:method) { :no_edit_button } }
  it_behaves_like('empty local_assigns') { let(:method) { :no_delete_button } }
  it_behaves_like('empty local_assigns') { let(:method) { :no_index_button } }
  it_behaves_like('empty local_assigns') { let(:method) { :no_show_link } }
end
