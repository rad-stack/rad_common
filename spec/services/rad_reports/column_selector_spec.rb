require 'rails_helper'

RSpec.describe RadReports::ColumnSelector, type: :service do
  let(:model_class) { Division }
  let(:joins) { [] }
  let(:custom_report) do
    build :custom_report,
          report_model: model_class.name,
          joins: joins,
          columns: columns_data,
          filters: []
  end
  let(:report) { RadReports::Report.new(custom_report: custom_report, current_user: nil, params: {}) }
  let(:column_selector) { described_class.new(report: report) }
  let(:query) { model_class.all }

  describe '#apply_column_selection' do
    subject(:result) { column_selector.apply_column_selection(query) }

    context 'with no columns' do
      let(:columns_data) { [] }

      it 'returns query unchanged' do
        expect(result).to eq query
      end
    end

    context 'with regular columns only' do
      let(:columns_data) do
        [
          { 'name' => 'name', 'select' => 'name', 'label' => 'Name', 'sortable' => true },
          { 'name' => 'description', 'select' => 'description', 'label' => 'Description', 'sortable' => true }
        ]
      end

      it 'builds select clauses with primary key' do
        expect(result.to_sql).to include('SELECT "divisions"."id", name AS name, description AS description')
      end
    end

    context 'with association columns' do
      let(:joins) { ['owner'] }
      let(:columns_data) do
        [
          { 'name' => 'name', 'select' => 'name', 'label' => 'Name', 'sortable' => true },
          { 'name' => 'email', 'select' => 'owner.email', 'label' => 'Owner Email', 'sortable' => true }
        ]
      end

      it 'converts association paths to table paths' do
        sql = result.to_sql
        expect(sql).to include('"divisions"."id"')
        expect(sql).to include('name AS name')
        expect(sql).to include('owner_users.email AS owner_email')
      end
    end

    context 'with mixed regular and association columns' do
      let(:joins) { %w[owner category] }
      let(:columns_data) do
        [
          { 'name' => 'name', 'select' => 'name', 'label' => 'Division Name', 'sortable' => true },
          { 'name' => 'email', 'select' => 'owner.email', 'label' => 'Owner Email', 'sortable' => true },
          { 'name' => 'category_name', 'select' => 'category.name', 'label' => 'Category Name', 'sortable' => true }
        ]
      end

      it 'handles multiple associations correctly' do
        sql = result.to_sql
        expect(sql).to include('"divisions"."id"')
        expect(sql).to include('name AS name')
        expect(sql).to include('owner_users.email AS owner_email')
        expect(sql).to include('category_categories.name AS category_name')
      end
    end

    context 'with nested association columns' do
      let(:joins) { %w[owner owner.user_status] }
      let(:columns_data) do
        [
          { 'name' => 'name', 'select' => 'name', 'label' => 'Name', 'sortable' => true },
          { 'name' => 'status_name', 'select' => 'owner.user_status.name', 'label' => 'Status', 'sortable' => true }
        ]
      end

      it 'converts nested association paths correctly' do
        sql = result.to_sql
        expect(sql).to include('"divisions"."id"')
        expect(sql).to include('name AS name')
        expect(sql).to include('owner_user_status_user_statuses.name AS owner_user_status_name')
      end
    end
  end

  describe '#convert_to_sql_select' do
    let(:joins) { %w[owner owner.user_status] }
    let(:columns_data) { [] }

    it 'returns simple column unchanged' do
      expect(column_selector.send(:convert_to_sql_select, 'name')).to eq 'name'
    end

    it 'returns simple table.column unchanged' do
      expect(column_selector.send(:convert_to_sql_select, 'divisions.name')).to eq 'divisions.name'
    end

    it 'converts association path to table path' do
      expect(column_selector.send(:convert_to_sql_select, 'owner.email')).to eq 'owner_users.email'
    end

    it 'converts nested association path to table path' do
      expect(column_selector.send(:convert_to_sql_select,
                                  'owner.user_status.name')).to eq 'owner_user_status_user_statuses.name'
    end

    it 'falls back to association path when table mapping not found' do
      expect(column_selector.send(:convert_to_sql_select, 'unknown.field')).to eq 'unknown.field'
    end
  end
end
