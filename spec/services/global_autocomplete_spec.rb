require 'rails_helper'
include RadCommon::ApplicationHelper

RSpec.describe GlobalAutocomplete, type: :service do

  describe '#global_autocomplete_result' do
    let!(:user) { create(:user) }
    let!(:search_user) { create(:user, first_name: 'Alex', last_name: 'Smith') }
    let!(:another_search_user) { create(:user, first_name: 'John', last_name: 'Smith') }
    let(:search_scopes) { Rails.application.config.global_search_scopes }
    let(:term) { search_user.last_name }
    let(:params) { ActionController::Parameters.new({ term: term, global_search_scope: 'user_name' }) }
    let(:auto_complete) { described_class.new(params, search_scopes, user) }

    before(:each) { allow_any_instance_of(User).to receive(:can_read?).and_return(true) }

    context 'search scopes empty' do
      let(:auto_complete) { described_class.new(params, [], user) }
      it 'returns empty array' do
        expect(auto_complete.global_autocomplete_result).to eq([])
      end
    end

    context 'model has query where' do
      it 'performs search based on specified query' do
        result = auto_complete.global_autocomplete_result
        expect(result.count).to eq(2)
        expect(result.first[:columns]).to eq([search_user.email])
        expect(result.first[:model_name]).to eq('User')
        expect(result.first[:id]).to eq(search_user.id)
        expect(result.first[:label]).to eq(search_user.to_s)
        expect(result.first[:value]).to eq(search_user.to_s)
        expect(result[1][:label]).to eq(another_search_user.to_s)
      end
    end

    context 'model does not have query where' do
      let(:params) { ActionController::Parameters.new({ term: term, global_search_scope: 'user_name_with_no_where' }) }
      let(:term) { search_user.email }
      let(:column) { 'email' }

      it 'builds query based on provided columns' do
        scopes = search_scopes.dup
        scopes[1][:columns] = [column]
        auto_complete = GlobalAutocomplete.new(params, scopes, user)

        result = auto_complete.global_autocomplete_result
        expect(result.count).to eq(1)
        expect(result.first[:columns]).to eq([search_user.email])
        expect(result.first[:model_name]).to eq('User')
        expect(result.first[:id]).to eq(search_user.id)
        expect(result.first[:label]).to eq(search_user.to_s)
        expect(result.first[:value]).to eq(search_user.to_s)
      end
    end

    context 'member can read class' do
      it 'returns results' do
        allow_any_instance_of(User).to receive(:can_read?).and_return(true)
        expect(auto_complete.global_autocomplete_result).not_to eq([])
      end
    end

    context 'member cannot read class' do
      it 'returns empty array' do
        allow_any_instance_of(User).to receive(:can_read?).and_return(false)
        expect(auto_complete.global_autocomplete_result).to eq([])
      end
    end
  end

  describe '#get_columns_values' do
    let(:user) { create(:user) }
    let(:search_scopes) { Rails.application.config.global_search_scopes }
    let(:auto_complete) { described_class.new(params, search_scopes, user) }

    context 'columns present' do
      let(:params) { ActionController::Parameters.new({ global_search_scope: 'user_name' }) }
      let(:columns) { ['email', 'last_name'] }
      it 'returns array of record fields' do
        expect(auto_complete.get_columns_values(columns, user)).to eq([user.email, user.last_name])
      end
    end

    context 'no columns' do
      let(:params) { ActionController::Parameters.new({ global_search_scope: 'user_name_with_no_where' }) }
      it 'returns empty array' do
        expect(auto_complete.get_columns_values([], user)).to eq([])
      end
    end
  end

  describe '#format_column_value' do
    let(:user) { create(:user) }
    let(:search_scopes) { Rails.application.config.global_search_scopes }
    let(:params) { ActionController::Parameters.new(Hash.new) }
    let(:auto_complete) { described_class.new(params, search_scopes, user) }
    let(:blank) { '' }
    let(:date) { Date.current }
    let(:string) { 'foobar' }

    context 'value blank' do
      it 'returns empty string' do
        expect(auto_complete.format_column_value(blank)).to eq('')
      end
    end

    context 'value date' do
      it 'returns formatted date' do
        date = Date.current
        expect(auto_complete.format_column_value(date)).to eq(format_date(date))
      end
    end

    context 'value not a date' do
      it 'returns value as is' do
        expect(auto_complete.format_column_value(string)).to eq(string)
      end
    end
  end
end
