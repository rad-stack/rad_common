require 'rails_helper'

RSpec.describe RadReports::ConfigurationBuilder, type: :service do
  describe '.build' do
    subject(:configuration) { described_class.build(params) }

    context 'with full parameter set' do
      let(:params) do
        {
          columns: [
            { id: 'name', label: 'Name', formula: '[{"type":"UPPER"}]' },
            { id: 'notes', label: 'Notes' }
          ],
          filters: {
            '0' => { id: 'status', type: 'RadSearch::EqualsFilter' }
          },
          sort_columns: [
            { id: 'created_at', direction: 'desc' }
          ],
          joins: ['users', '', nil, 'addresses']
        }
      end

      it 'builds configuration with processed sections' do
        expect(configuration.keys).to contain_exactly('columns', 'filters', 'sort_columns', 'joins')

        columns = configuration['columns']
        expect(columns).to be_an(Array)
        expect(columns.first[:id]).to eq('name')
        expect(columns.first['formula']).to eq([{ 'type' => 'UPPER' }])
        expect(columns.last[:id]).to eq('notes')

        expect(configuration['filters']).to eq([{ id: 'status', type: 'RadSearch::EqualsFilter' }])
        expect(configuration['sort_columns']).to eq([{ id: 'created_at', direction: 'desc' }])
        expect(configuration['joins']).to eq(%w[users addresses])
      end
    end

    context 'with minimal parameters' do
      let(:params) { {} }

      it 'returns empty configuration hash' do
        expect(configuration).to eq({})
      end
    end

    context 'with hash-based sort columns' do
      let(:params) do
        {
          sort_columns: {
            '0' => { id: 'name', direction: 'asc' },
            '1' => { id: 'created_at', direction: 'desc' }
          }
        }
      end

      it 'converts hash to array preserving order of values' do
        expect(configuration['sort_columns']).to contain_exactly(
          { id: 'name', direction: 'asc' },
          { id: 'created_at', direction: 'desc' }
        )
      end
    end

    context 'with invalid formula JSON' do
      let(:params) do
        {
          columns: [
            { id: 'name', formula: 'not json' }
          ]
        }
      end

      it 'falls back to original column hash' do
        column = configuration['columns'].first
        expect(column[:formula]).to eq('not json')
        expect(column).not_to have_key('formula')
      end
    end
  end

  describe '.sanitize_joins' do
    subject(:sanitized) { described_class.sanitize_joins(joins) }

    context 'with nil joins' do
      let(:joins) { nil }

      it 'returns empty array' do
        expect(sanitized).to eq([])
      end
    end

    context 'with single join string' do
      let(:joins) { 'accounts' }

      it 'wraps the join in an array' do
        expect(sanitized).to eq(['accounts'])
      end
    end

    context 'with array including blanks' do
      let(:joins) { ['users', '', nil, 'profiles'] }

      it 'removes blank entries' do
        expect(sanitized).to eq(%w[users profiles])
      end
    end
  end
end
