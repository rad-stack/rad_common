require 'rails_helper'

RSpec.describe CustomReportFilter do
  let(:filter) do
    described_class.new(column: 'name', type: 'like', label: 'Name Filter', report_model: 'Division', joins: [])
  end

  describe '#validate_column_exists' do
    context 'with valid base model column' do
      let(:filter) do
        described_class.new(column: 'name', type: 'like', label: 'Name Filter', report_model: 'Division', joins: [])
      end

      it 'does not add errors' do
        filter.valid?
        expect(filter.errors[:column]).to be_empty
      end
    end

    context 'with valid joined column' do
      let(:filter) do
        described_class.new(column: 'owner.email', type: 'like', label: 'Owner Email', report_model: 'Division',
                            joins: ['owner'])
      end

      it 'does not add errors' do
        filter.valid?
        expect(filter.errors[:column]).to be_empty
      end
    end

    context 'with nested join column' do
      let(:filter) do
        described_class.new(column: 'owner.user_status.name', type: 'like', label: 'Status', report_model: 'Division',
                            joins: ['owner.user_status'])
      end

      it 'does not add errors' do
        filter.valid?
        expect(filter.errors[:column]).to be_empty
      end
    end

    context 'with table name reference' do
      let(:filter) do
        described_class.new(column: 'users.email', type: 'like', label: 'User Email', report_model: 'Division',
                            joins: ['owner'])
      end

      it 'does not add errors' do
        filter.valid?
        expect(filter.errors[:column]).to be_empty
      end
    end

    context 'with invalid column' do
      let(:filter) do
        described_class.new(column: 'nonexistent_column', type: 'like', label: 'Invalid', report_model: 'Division',
                            joins: [])
      end

      it 'adds error' do
        filter.valid?
        expect(filter.errors[:column]).to include(
          "contains invalid column reference 'nonexistent_column'. " \
          "Available columns can be found using the model and joins you've specified."
        )
      end
    end

    context 'with invalid association' do
      let(:filter) do
        described_class.new(column: 'invalid_association.name', type: 'like', label: 'Invalid Association',
                            report_model: 'Division', joins: [])
      end

      it 'adds error' do
        filter.valid?
        expect(filter.errors[:column]).to include(
          "contains invalid column reference 'invalid_association.name'. " \
          "Available columns can be found using the model and joins you've specified.")
      end
    end

    context 'with valid column but wrong association' do
      let(:filter) do
        described_class.new(column: 'owner.nonexistent_column', type: 'like', label: 'Wrong Column',
                            report_model: 'Division', joins: ['owner'])
      end

      it 'adds error' do
        filter.valid?
        expect(filter.errors[:column]).to include(
          "contains invalid column reference 'owner.nonexistent_column'. " \
          "Available columns can be found using the model and joins you've specified."
        )
      end
    end

    context 'with blank column' do
      let(:filter) do
        described_class.new(column: '', type: 'like', label: 'Empty Column', report_model: 'Division', joins: [])
      end

      it 'does not validate column existence' do
        filter.valid?
        expect(filter.errors[:column]).not_to include(a_string_matching(/contains invalid column reference/))
      end
    end

    context 'with blank report model' do
      let(:filter) do
        described_class.new(column: 'name', type: 'like', label: 'Name Filter', report_model: '', joins: [])
      end

      it 'does not validate column existence' do
        filter.valid?
        expect(filter.errors[:column]).not_to include(a_string_matching(/contains invalid column reference/))
      end
    end
  end

  describe '#validate_filter_type' do
    context 'with valid filter type' do
      let(:filter) do
        described_class.new(column: 'name', type: 'RadSearch::LikeFilter', label: 'Name Filter',
                            report_model: 'Division', joins: [])
      end

      it 'does not add errors' do
        filter.valid?
        expect(filter.errors[:type]).to be_empty
      end
    end

    context 'with invalid filter type' do
      let(:filter) do
        described_class.new(column: 'name', type: 'invalid_type', label: 'Name Filter', report_model: 'Division',
                            joins: [])
      end

      it 'adds error' do
        filter.valid?
        expect(filter.errors[:type]).to include("invalid filter type 'invalid_type'")
      end
    end

    context 'with blank filter type' do
      let(:filter) do
        described_class.new(column: 'name', type: '', label: 'Name Filter', report_model: 'Division', joins: [])
      end

      it 'does not validate filter type' do
        filter.valid?
        expect(filter.errors[:type]).not_to include(a_string_matching(/invalid filter type/))
      end
    end
  end

  describe '#from_filter_config' do
    let(:filter_config) do
      {
        'column' => 'owner.email',
        'type' => 'like',
        'label' => 'Owner Email Filter'
      }
    end

    let(:filter) { described_class.from_filter_config(filter_config, report_model: 'Division', joins: ['owner']) }

    it 'creates filter with correct attributes' do
      expect(filter.column).to eq 'owner.email'
      expect(filter.type).to eq 'like'
      expect(filter.label).to eq 'Owner Email Filter'
      expect(filter.report_model).to eq 'Division'
      expect(filter.joins).to eq ['owner']
    end
  end

  describe '#to_filter_config' do
    let(:filter) do
      described_class.new(column: 'name', type: 'like', label: 'Name Filter', report_model: 'Division', joins: [])
    end

    it 'returns hash with column, type, and label' do
      expect(filter.to_filter_config).to eq({ 'column' => 'name', 'type' => 'like', 'label' => 'Name Filter' })
    end
  end
end
