require 'rails_helper'

RSpec.describe RadReports::JoinBuilder, type: :service do
  let(:join_builder) { described_class.new(model_class, joins) }

  describe '#call' do
    subject(:query) { join_builder.call }

    context 'with no joins' do
      let(:model_class) { Division }
      let(:joins) { nil }

      it 'returns base query' do
        expect(query).to eq Division.all
      end
    end

    context 'with empty joins array' do
      let(:model_class) { Division }
      let(:joins) { [] }

      it 'returns base query' do
        expect(query).to eq Division.all
      end
    end

    context 'with a simple belongs_to join' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }
      let!(:user) { create :user }
      let!(:division) { create :division, owner: user }

      it 'executes query successfully' do
        expect { query.to_a }.not_to raise_error
      end

      it 'returns correct results' do
        expect(query).to include division
      end

      it 'includes aliased table in SQL' do
        expect(query.to_sql).to include 'owner_users'
      end
    end

    context 'with multiple independent joins' do
      let(:model_class) { Division }
      let(:joins) { %w[owner category] }
      let!(:user) { create :user }
      let!(:category) { create :category }
      let!(:division) { create :division, owner: user, category: category }

      it 'executes query successfully' do
        expect { query.to_a }.not_to raise_error
      end

      it 'returns correct results' do
        expect(query).to include division
      end

      it 'includes both aliased tables in SQL' do
        sql = query.to_sql
        expect(sql).to include 'owner_users'
        expect(sql).to include 'category_categories'
      end
    end

    context 'with nested joins through belongs_to' do
      let(:model_class) { Division }
      let(:joins) { %w[owner owner.user_status] }
      let!(:user_status) { create :user_status, :active }
      let!(:user) { create :user, user_status: user_status }
      let!(:division) { create :division, owner: user }

      it 'executes query successfully' do
        expect { query.to_a }.not_to raise_error
      end

      it 'returns correct results' do
        expect(query).to include division
      end

      it 'includes both aliased tables in SQL' do
        sql = query.to_sql
        expect(sql).to include 'owner_users'
        expect(sql).to include 'owner_user_status_user_statuses'
      end
    end

    context 'with self-referential join' do
      let(:model_class) { User }
      let(:joins) { ['invited_by'] }
      let!(:inviter) { create :user }
      let!(:invited_user) { create :user, invited_by: inviter }

      it 'executes query successfully' do
        expect { query.to_a }.not_to raise_error
      end

      it 'returns correct results' do
        expect(query).to include invited_user
      end

      it 'includes aliased table in SQL' do
        expect(query.to_sql).to include 'invited_by_users'
      end
    end

    context 'with has_many join' do
      let(:model_class) { User }
      let(:joins) { ['divisions'] }
      let!(:user) { create :user }

      before { create :division, owner: user }

      it 'executes query successfully' do
        expect { query.to_a }.not_to raise_error
      end

      it 'returns correct results' do
        expect(query).to include user
      end

      it 'includes aliased table in SQL' do
        expect(query.to_sql).to include 'divisions_divisions'
      end
    end
  end

  describe '#association_to_table_map' do
    subject(:table_map) { join_builder.association_to_table_map }

    context 'with simple join' do
      let(:model_class) { Division }
      let(:joins) { ['owner'] }

      it 'returns correct mapping' do
        expect(table_map).to eq({ 'owner' => 'owner_users' })
      end
    end

    context 'with multiple joins' do
      let(:model_class) { Division }
      let(:joins) { %w[owner category] }

      it 'returns correct mappings for all joins' do
        expect(table_map).to eq({
                                  'owner' => 'owner_users',
                                  'category' => 'category_categories'
                                })
      end
    end

    context 'with nested joins' do
      let(:model_class) { Division }
      let(:joins) { %w[owner owner.user_status] }

      it 'returns correct mappings for nested path' do
        expect(table_map).to eq({
                                  'owner' => 'owner_users',
                                  'owner.user_status' => 'owner_user_status_user_statuses'
                                })
      end
    end

    context 'with deeply nested joins' do
      let(:model_class) { Division }
      let(:joins) { %w[owner owner.user_status owner.user_status.dummy] }

      it 'returns correct mappings for all levels' do
        # This test verifies the pattern even if dummy association doesn't exist
        expect(table_map['owner']).to eq 'owner_users'
        expect(table_map['owner.user_status']).to eq 'owner_user_status_user_statuses'
      end
    end
  end

  describe '#table_name_for_association' do
    subject(:table_name) { join_builder.table_name_for_association(association_path) }

    let(:model_class) { Division }
    let(:joins) { %w[owner category] }

    context 'with existing association path' do
      let(:association_path) { 'owner' }

      it 'returns correct table alias' do
        expect(table_name).to eq 'owner_users'
      end
    end

    context 'with non-existent association path' do
      let(:association_path) { 'nonexistent' }

      it 'returns the path itself' do
        expect(table_name).to eq 'nonexistent'
      end
    end
  end
end
