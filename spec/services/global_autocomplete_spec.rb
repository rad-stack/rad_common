require 'rails_helper'
include RadCommon::ApplicationHelper

RSpec.describe GlobalAutocomplete, type: :service do
  let!(:user) { create(:user) }
  let!(:search_user) { create(:user, first_name: 'Alex', last_name: 'Smith') }
  let!(:another_search_user) { create(:user, first_name: 'John', last_name: 'Smith') }
  let(:search_scopes) { Rails.application.config.global_search_scopes }
  let(:params) { ActionController::Parameters.new(Hash.new) }
  let(:auto_complete) { described_class.new(params, search_scopes, user) }

  describe '#global_autocomplete_result' do
    before(:each) { allow_any_instance_of(User).to receive(:can_read?).and_return(true) }

    it 'returns results from selected scope' do
      scope = auto_complete.selected_scope
      expect(auto_complete.global_autocomplete_result).to eq(auto_complete.autocomplete_result(scope))
    end

    context 'search scopes empty' do
      let(:auto_complete) { described_class.new(params, [], user) }
      it 'returns empty array' do
        expect(auto_complete.global_autocomplete_result).to eq([])
      end
    end
  end

  describe '#autocomplete_result' do
    let(:term) { search_user.last_name }
    let(:params) { ActionController::Parameters.new({ term: term, global_search_scope: 'user_name' }) }
    let(:scope) { auto_complete.selected_scope }

    before(:each) { allow_any_instance_of(User).to receive(:can_read?).and_return(true) }

    context 'scope has query where' do
      let(:result) { auto_complete.autocomplete_result(scope) }
      it 'performs search based on specified query' do
        expect(result.count).to eq(2)
        expect(result.first[:columns]).to eq([search_user.email])
        expect(result.first[:model_name]).to eq('User')
        expect(result.first[:id]).to eq(search_user.id)
        expect(result.first[:label]).to eq(search_user.to_s)
        expect(result.first[:value]).to eq(search_user.to_s)
        expect(result[1][:label]).to eq(another_search_user.to_s)
      end

      it 'should have scope description' do
        expect(result.first[:scope_description]).to eq(scope[:description])
      end
    end

    context 'scope has no query where' do
      let(:params) { ActionController::Parameters.new({ term: term, global_search_scope: 'user_name_with_no_where' }) }

      context 'without columns' do
        it 'returns all records' do
          expect(auto_complete.autocomplete_result(scope).count).to eq(User.count)
        end
      end

      context 'with columns' do
        let(:term) { search_user.email }
        let(:column) { 'email' }

        it 'builds query based on provided columns' do
          scopes = search_scopes.dup
          scopes[2][:columns] = [column]
          auto_complete = GlobalAutocomplete.new(params, scopes, user)

          result = auto_complete.autocomplete_result(scope)
          expect(result.count).to eq(1)
          expect(result.first[:columns]).to eq([search_user.email])
          expect(result.first[:model_name]).to eq('User')
          expect(result.first[:id]).to eq(search_user.id)
          expect(result.first[:label]).to eq(search_user.to_s)
          expect(result.first[:value]).to eq(search_user.to_s)
        end
      end
    end

    context 'invalid global_search_scope param' do
      let(:params) { ActionController::Parameters.new({ term: term, global_search_scope: 'foobar' }) }
      it 'returns empty array' do
        expect(auto_complete.autocomplete_result(scope)).to eq([])
      end
    end

    context 'user cannot read class' do
      it 'returns empty array' do
        allow_any_instance_of(User).to receive(:can_read?).and_return(false)
        expect(auto_complete.autocomplete_result(scope)).to eq([])
      end
    end
  end

  describe '#global_super_search_result' do
    let(:term) { 'Peters' }
    let(:params) { ActionController::Parameters.new({ term: term }) }
    let!(:another_user) { create(:user, last_name: term, email: "#{term}@example.com") }
    let!(:division) { create(:division, name: term) }

    before(:each) { allow_any_instance_of(User).to receive(:can_read?).and_return(true) }

    it 'includes results from multiple scopes' do
      result = auto_complete.global_super_search_result
      expect(result.count).to eq(2)
      expect(result.first[:model_name]).to eq('User')
      expect(result.first[:value]).to include(term)
      expect(result[1][:model_name]).to eq('Division')
      expect(result[1][:value]).to eq(term)
    end

    it 'excludes duplicates' do
      result = auto_complete.global_super_search_result
      records = result.map { |item| { id: item[:id], model_name: item[:model_name] } }
      expect(records.uniq.length).to eq(records.length)
    end

    context 'super_search_exclude' do
      it 'excludes scopes with super_search_exclude marked true' do
        scopes = search_scopes.dup
        scopes[3][:super_search_exclude] = true
        auto_complete = GlobalAutocomplete.new(params, scopes, user)
        result = auto_complete.global_super_search_result
        expect(result.count).to eq(1)
      end
    end
  end

  describe '#get_columns_values' do
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

    context 'value datetime' do
      it 'returns formatted datetime' do
        datetime = Time.zone.now
        expect(auto_complete.format_column_value(datetime)).to eq(format_datetime(datetime))
      end
    end

    context 'value not a date' do
      it 'returns value as is' do
        expect(auto_complete.format_column_value(string)).to eq(string)
      end
    end
  end

  describe '#scope_name' do
    context 'global search scope present' do
      global_search_scope = 'user_name_with_no_where'
      let(:params) { ActionController::Parameters.new({ global_search_scope: global_search_scope }) }
      it 'returns global search scope' do
        expect(auto_complete.scope_name).to eq(global_search_scope)
      end
    end

    context 'global search scope not present' do
      let(:params) { ActionController::Parameters.new({ global_search_scope: '' }) }
      it 'returns first search scope name' do
        expect(auto_complete.scope_name).to eq(search_scopes.first[:name])
      end
    end
  end

  describe '#selected_scope' do
    context 'search scopes not empty' do
      it 'returns scopes matching scope name' do
        name = auto_complete.scope_name
        expect(auto_complete.selected_scope[:name]).to eq(name)
      end
    end

    context 'search scopes empty' do
      let(:auto_complete) { described_class.new(params, [], user) }
      it 'returns nil' do
        expect(auto_complete.selected_scope).to be_nil
      end
    end
  end

  describe '#where_query' do
    context 'no query where' do
      let(:params) { ActionController::Parameters.new({ global_search_scope: 'user_name_with_no_where' }) }
      context 'string column' do
        let(:column) { 'email' }

        it 'returns string query' do
          scopes = search_scopes.dup
          scopes[2][:columns] = [column]
          auto_complete = GlobalAutocomplete.new(params, scopes, user)
          expect(auto_complete.where_query).to eq("#{column} ILIKE :search")
        end
      end

      context 'other column' do
        let(:column) { 'created_at' }
        it 'returns date query' do
          scopes = search_scopes.dup
          scopes[2][:columns] = [column]
          auto_complete = GlobalAutocomplete.new(params, scopes, user)
          expect(auto_complete.where_query).to eq("CAST(#{column} AS TEXT) LIKE :search")
        end
      end
    end

    context 'query where' do
      let(:params) { ActionController::Parameters.new({ global_search_scope: 'user_name' }) }

      it 'returns query where from scope' do
        query_where = search_scopes.first[:query_where]
        expect(auto_complete.where_query).to eq(query_where)
      end
    end
  end
end
