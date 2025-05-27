require 'rails_helper'

RSpec.describe GlobalAutocomplete, type: :service do
  include RadCommon::ApplicationHelper

  let!(:user) { create :user }
  let!(:search_user) { create :user, first_name: 'Alex', last_name: 'Smith' }
  let!(:another_search_user) { create :user, first_name: 'John', last_name: 'Smith' }
  let!(:division) { create :division }
  let(:search_scopes) { RadConfig.global_search_scopes! }
  let(:params) { ActionController::Parameters.new }
  let(:auto_complete) { described_class.new(params, search_scopes, user, :searchable_association) }

  describe '#global_autocomplete_result' do
    context 'when searching users' do
      before { allow_any_instance_of(UserPolicy).to receive(:index?).and_return(true) }

      it 'returns results from selected scope' do
        scope = auto_complete.send(:selected_scope)
        expect(auto_complete.global_autocomplete_result).to eq(auto_complete.send(:autocomplete_result, scope))
      end

      context 'when search scopes empty' do
        let(:auto_complete) { described_class.new(params, [], user, :searchable_association) }

        it 'returns empty array' do
          expect(auto_complete.global_autocomplete_result).to eq([])
        end
      end
    end

    context 'when searching divisions' do
      let(:params) { ActionController::Parameters.new(term: division.name, global_search_scope: 'division_name') }
      let(:result) { auto_complete.global_autocomplete_result }

      context 'when admin' do
        let(:user) { create :admin }

        it 'returns results' do
          user
          expect(result.count).to eq(1)
          expect(result.first[:id]).to eq division.id
        end
      end

      context 'when user owner' do
        let!(:user) { division.owner }

        before { user.security_roles.first.update! read_division: true }

        it 'returns results' do
          expect(result.count).to eq(1)
          expect(result.first[:id]).to eq division.id
        end
      end

      context 'when user non owner' do
        it 'returns results' do
          expect(result.count).to eq(0)
        end
      end
    end
  end

  describe '#autocomplete_result' do
    let(:term) { search_user.last_name }
    let(:params) { ActionController::Parameters.new(term: term, global_search_scope: 'user_name') }
    let(:scope) { auto_complete.send(:selected_scope) }

    before { allow_any_instance_of(UserPolicy).to receive(:index?).and_return(true) }

    context "when excluding id's" do
      let(:user) { create :admin }
      let(:term) { 'Testing' }

      let!(:division_1) { create :division, name: "#{term} 1" }
      let!(:division_2) { create :division, name: "#{term} 2" }
      let!(:division_3) { create :division, name: "#{term} 3" }

      let(:params) do
        ActionController::Parameters.new(term: term,
                                         global_search_scope: 'division_name',
                                         excluded_ids: [division_2.id, division_3.id])
      end

      let(:result) { auto_complete.send(:autocomplete_result, scope) }

      it 'finds the records exluding some' do
        expect(result.count).to eq(1)
        expect(result.first[:model_name].constantize.find(result.first[:id])).to eq division_1
      end
    end

    context 'when scope has join' do
      let(:term) { 'My Division' }
      let!(:division) { create :division, name: term }
      let(:params) { ActionController::Parameters.new(term: term, global_search_scope: 'user_by_division_name') }
      let(:result) { auto_complete.send(:autocomplete_result, scope) }

      it 'finds results on joined table' do
        expect(result.count).to eq(1)
        expect(result.first[:model_name].constantize.find(result.first[:id])).to eq division.owner
      end
    end

    context 'when scope has query where' do
      let(:result) { auto_complete.send(:autocomplete_result, scope) }

      it 'performs search based on specified query' do
        expect(result.count).to eq(2)
        expect(result.first[:columns]).to eq([search_user.email, search_user.user_status.to_s])
        expect(result.first[:model_name]).to eq('User')
        expect(result.first[:id]).to eq(search_user.id)
        expect(result.first[:label]).to eq(search_user.to_s)
        expect(result.first[:value]).to eq(search_user.to_s)
        expect(result[1][:label]).to eq(another_search_user.to_s)
      end

      it 'has scope description' do
        expect(result.first[:scope_description]).to eq(scope[:description])
      end
    end

    context 'when invalid global_search_scope param' do
      let(:params) { ActionController::Parameters.new(term: term, global_search_scope: 'foobar') }

      it 'raises an exception' do
        expect(&method(:auto_complete)).to raise_exception 'Invalid global scope foobar'
      end
    end

    context 'when user cannot read class' do
      it 'returns empty array' do
        allow_any_instance_of(UserPolicy).to receive(:index?).and_return(false)
        expect(auto_complete.send(:autocomplete_result, scope)).to eq([])
      end
    end
  end

  describe '#global_super_search_result' do
    let(:term) { 'Peters' }
    let(:params) { ActionController::Parameters.new(term: term) }

    before do
      create :user, last_name: term, email: "#{term}@example.com"
      create :division, name: term, owner: user

      allow_any_instance_of(UserPolicy).to receive(:index?).and_return(true)
    end

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

    context 'when super_search_exclude' do
      it 'excludes scopes with super_search_exclude marked true' do
        scopes = search_scopes.dup
        scopes[2][:super_search_exclude] = true
        auto_complete = described_class.new(params, scopes, user, :searchable_association)
        result = auto_complete.global_super_search_result
        expect(result.count).to eq(1)
      end
    end

    context "when excluding id's" do
      let(:params) { ActionController::Parameters.new(term: term, excluded_ids: [999]) }

      it 'is not applicable and raises an exception' do
        expect { auto_complete.global_super_search_result }.to raise_error RuntimeError
      end
    end
  end

  describe '#get_columns_values' do
    let(:params) { ActionController::Parameters.new(global_search_scope: 'user_name') }
    let(:columns) { %w[email last_name] }
    let(:methods) { [:user_status] }
    let(:result) { [user.email, user.last_name, user.user_status.name] }

    it 'returns array of record fields' do
      expect(auto_complete.send(:get_columns_values, columns, methods, user)).to eq(result)
    end
  end

  describe '#format_column_value' do
    let(:blank) { '' }
    let(:date) { Date.current }
    let(:string) { 'foobar' }

    context 'when value blank' do
      it 'returns empty string' do
        expect(auto_complete.send(:format_column_value, blank)).to eq('')
      end
    end

    context 'when value date' do
      it 'returns formatted date' do
        date = Date.current
        expect(auto_complete.send(:format_column_value, date)).to eq(format_date(date))
      end
    end

    context 'when value datetime' do
      it 'returns formatted datetime' do
        datetime = Time.current
        expect(auto_complete.send(:format_column_value, datetime)).to eq(format_datetime(datetime))
      end
    end

    context 'when value not a date' do
      it 'returns value as is' do
        expect(auto_complete.send(:format_column_value, string)).to eq(string)
      end
    end
  end

  describe '#scope_name' do
    context 'when global search scope not present' do
      let(:params) { ActionController::Parameters.new(global_search_scope: '') }

      it 'returns first search scope name' do
        expect(auto_complete.send(:scope_name)).to eq(search_scopes.first[:name])
      end
    end
  end

  describe '#selected_scope' do
    context 'when search scopes not empty' do
      it 'returns scopes matching scope name' do
        name = auto_complete.send(:scope_name)
        result = auto_complete.send(:selected_scope)
        expect(result[:name]).to eq(name)
      end
    end

    context 'when search scopes empty' do
      let(:auto_complete) { described_class.new(params, [], user, :searchable_association) }

      it 'returns nil' do
        expect(auto_complete.send(:selected_scope)).to be_nil
      end
    end
  end

  describe '#where_query' do
    let(:params) { ActionController::Parameters.new(global_search_scope: 'user_name') }

    it 'returns query where from scope' do
      query_where = search_scopes.first[:query_where]
      expect(auto_complete.send(:where_query)).to eq(query_where)
    end
  end
end
