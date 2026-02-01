require 'rails_helper'

RSpec.describe RadReports::FilterRegistry, type: :service do
  describe '.all' do
    subject(:all_filters) { described_class.all }

    it 'returns hash with all filter definitions' do
      expect(all_filters).to be_a(Hash)
      expect(all_filters.keys).to include(
        'RadSearch::LikeFilter',
        'RadSearch::DateFilter',
        'RadSearch::BooleanFilter',
        'RadSearch::SearchFilterMultiple'
      )
    end
  end

  describe '.find' do
    subject(:filter) { described_class.find(class_name) }

    context 'with valid filter class name' do
      let(:class_name) { 'RadSearch::DateFilter' }

      it 'returns filter definition' do
        expect(filter).to be_a(Hash)
        expect(filter).to have_key(:label)
        expect(filter).to have_key(:compatible_types)
      end
    end

    context 'with invalid filter class name' do
      let(:class_name) { 'RadSearch::InvalidFilter' }

      it 'returns nil' do
        expect(filter).to be_nil
      end
    end
  end

  describe '.all_options' do
    subject(:options) { described_class.all_options }

    it 'returns array of label/class_name pairs' do
      expect(options).to be_an(Array)
      expect(options.first).to be_an(Array)
      expect(options.first.length).to eq 2
    end
  end

  describe '.filters_for_column_type' do
    subject(:filters) { described_class.filters_for_column_type(column_type) }

    context 'with string column type' do
      let(:column_type) { 'string' }

      it 'returns text-compatible filters' do
        expect(filters).to include('RadSearch::LikeFilter')
        expect(filters).not_to include('RadSearch::DateFilter')
        expect(filters).not_to include('RadSearch::BooleanFilter')
      end
    end

    context 'with integer column type' do
      let(:column_type) { 'integer' }

      it 'excludes text-specific filters' do
        expect(filters).not_to include('RadSearch::LikeFilter')
      end
    end

    context 'with date column type' do
      let(:column_type) { 'date' }

      it 'returns only DateFilter' do
        expect(filters).to eq(['RadSearch::DateFilter'])
      end
    end

    context 'with boolean column type' do
      let(:column_type) { 'boolean' }

      it 'returns only BooleanFilter' do
        expect(filters).to eq(['RadSearch::BooleanFilter'])
      end
    end

    context 'with unknown column type' do
      let(:column_type) { 'unknown_type' }

      it 'defaults to string filters' do
        expect(filters).to include('RadSearch::LikeFilter')
      end
    end

    context 'with symbol column type' do
      let(:column_type) { :string }

      it 'converts symbol to string' do
        expect(filters).to include('RadSearch::LikeFilter')
      end
    end
  end

  describe '.options_for_column_type' do
    subject(:options) { described_class.options_for_column_type(column_type) }

    context 'with string column type' do
      let(:column_type) { 'string' }

      it 'returns label/class_name pairs' do
        expect(options).to be_an(Array)
        expect(options.first).to be_an(Array)
        expect(options.first.length).to eq 2
      end
    end

    context 'with unknown column type' do
      let(:column_type) { 'unknown_type' }

      it 'defaults to string filter options' do
        expect(options).to include(['Text Search (LIKE)', 'RadSearch::LikeFilter'])
      end
    end
  end

  describe '.column_type_filters' do
    subject(:mapping) { described_class.column_type_filters }

    it 'returns hash mapping column types to filters' do
      expect(mapping).to be_a(Hash)
      expect(mapping['string']).to be_an(Array)
      expect(mapping['date']).to be_an(Array)
    end

    it 'caches the result' do
      first_call = described_class.column_type_filters
      second_call = described_class.column_type_filters
      expect(first_call.object_id).to eq second_call.object_id
    end
  end
end
