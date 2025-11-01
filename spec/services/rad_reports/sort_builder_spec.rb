require 'rails_helper'

RSpec.describe RadReports::SortBuilder, type: :service do
  let(:join_builder) { RadReports::JoinBuilder.new(model_class, joins) }
  let(:sort_builder) { described_class.new(join_builder) }

  describe '#call' do
    subject(:sort_definitions) { sort_builder.call(columns) }

    context 'with no columns' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) { [] }

      it 'returns empty array' do
        expect(sort_definitions).to eq []
      end
    end

    context 'with simple column' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'name', 'select' => 'name', 'sortable' => true }]
      end

      it 'builds sort definition with humanized label' do
        expect(sort_definitions.length).to eq 1
        expect(sort_definitions.first[:label]).to eq 'Name'
        expect(sort_definitions.first[:column]).to eq 'name'
      end
    end

    context 'with custom label' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'name', 'label' => 'Division Name', 'select' => 'name', 'sortable' => true }]
      end

      it 'uses provided label' do
        expect(sort_definitions.first[:label]).to eq 'Division Name'
      end
    end

    context 'with non-sortable column' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'name', 'select' => 'name', 'sortable' => false }]
      end

      it 'sets column to nil' do
        expect(sort_definitions.first[:label]).to eq 'Name'
        expect(sort_definitions.first[:column]).to be_nil
      end
    end

    context 'with association column path' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let(:columns) do
        [{ 'name' => 'email', 'select' => 'owner.email', 'sortable' => true }]
      end

      it 'converts association path to table path' do
        expect(sort_definitions.first[:column]).to eq 'owner_users.email'
      end
    end

    context 'with nested association column path' do
      let(:model_class) { Division }
      let(:joins) { %w[owner owner.user_status] }
      let(:columns) do
        [{ 'name' => 'name', 'select' => 'owner.user_status.name', 'sortable' => true }]
      end

      it 'converts nested association path to table path' do
        expect(sort_definitions.first[:column]).to eq 'owner_user_status_user_statuses.name'
      end
    end

    context 'with simple table.column path' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'id', 'select' => 'divisions.id', 'sortable' => true }]
      end

      it 'returns path unchanged for simple table.column' do
        expect(sort_definitions.first[:column]).to eq 'divisions.id'
      end
    end

    context 'with mixed sortable and non-sortable columns' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let(:columns) do
        [
          { 'name' => 'name', 'label' => 'Division Name', 'select' => 'name', 'sortable' => true },
          { 'name' => 'description', 'select' => 'description', 'sortable' => false },
          { 'name' => 'email', 'select' => 'owner.email', 'sortable' => true }
        ]
      end

      it 'builds all sort definitions correctly' do
        expect(sort_definitions.length).to eq 3

        expect(sort_definitions[0][:label]).to eq 'Division Name'
        expect(sort_definitions[0][:column]).to eq 'name'

        expect(sort_definitions[1][:label]).to eq 'Description'
        expect(sort_definitions[1][:column]).to be_nil

        expect(sort_definitions[2][:label]).to eq 'Email'
        expect(sort_definitions[2][:column]).to eq 'owner_users.email'
      end
    end

    context 'with blank select clause' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'name', 'select' => '', 'sortable' => true }]
      end

      it 'returns nil for column when select is blank' do
        expect(sort_definitions.first[:column]).to be_nil
      end
    end

    context 'with nil select clause' do
      let(:model_class) { Division }
      let(:joins) { nil }
      let(:columns) do
        [{ 'name' => 'name', 'select' => nil, 'sortable' => true }]
      end

      it 'returns nil for column when select is nil' do
        expect(sort_definitions.first[:column]).to be_nil
      end
    end
  end

  describe '#convert_sort_column_path' do
    let(:model_class) { Division }
    let(:joins) { %w[owner owner.user_status] }
    let(:sort_builder) { described_class.new(join_builder) }

    it 'returns nil for blank column path' do
      expect(sort_builder.convert_sort_column_path('')).to be_nil
      expect(sort_builder.convert_sort_column_path(nil)).to be_nil
    end

    it 'returns path unchanged for simple column' do
      expect(sort_builder.convert_sort_column_path('name')).to eq 'name'
    end

    it 'returns path unchanged for simple table.column' do
      expect(sort_builder.convert_sort_column_path('divisions.name')).to eq 'divisions.name'
    end

    it 'converts association path to table path' do
      expect(sort_builder.convert_sort_column_path('owner.email')).to eq 'owner_users.email'
    end

    it 'converts nested association path to table path' do
      expect(sort_builder.convert_sort_column_path('owner.user_status.name'))
        .to eq 'owner_user_status_user_statuses.name'
    end
  end
end
