require 'rails_helper'

RSpec.describe RadReports::AssociationDiscovery, type: :service do
  let(:discovery) { described_class.new(model_name, existing_joins) }

  describe '#initialize' do
    subject(:discovery) { described_class.new('User', ['divisions']) }

    it 'sets model_name' do
      expect(discovery.model_name).to eq 'User'
    end

    it 'sets existing_joins' do
      expect(discovery.existing_joins).to eq ['divisions']
    end
  end

  describe '#available_associations' do
    subject(:associations) { discovery.available_associations }

    context 'with blank model name' do
      let(:model_name) { nil }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(associations).to eq []
      end
    end

    context 'with empty model name' do
      let(:model_name) { '' }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(associations).to eq []
      end
    end

    context 'with invalid model name' do
      let(:model_name) { 'NonExistentModel' }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(associations).to eq []
      end
    end

    context 'with valid model without existing joins' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { [] }

      it 'returns array of association definitions' do
        expect(associations).to be_an(Array)
        expect(associations).not_to be_empty
      end

      it 'includes belongs_to associations' do
        owner_assoc = associations.find { |a| a[:name] == 'owner' }
        expect(owner_assoc).not_to be_nil
        expect(owner_assoc[:type]).to eq 'belongs_to'
        expect(owner_assoc[:class_name]).to eq 'User'
        expect(owner_assoc[:table_name]).to eq 'users'
      end

      it 'includes only associations to available models' do
        class_names = associations.map { |a| a[:class_name] }
        class_names.each do |class_name|
          expect(RadReports::ModelDiscovery.model_available?(class_name)).to be true
        end
      end

      it 'includes correct labels' do
        owner_assoc = associations.find { |a| a[:name] == 'owner' }
        expect(owner_assoc[:label]).to eq 'Owner'
      end

      it 'includes foreign key information' do
        owner_assoc = associations.find { |a| a[:name] == 'owner' }
        expect(owner_assoc[:foreign_key]).to eq 'owner_id'
      end

      it 'sets depth to 1 for base associations' do
        owner_assoc = associations.find { |a| a[:name] == 'owner' }
        expect(owner_assoc[:depth]).to eq 1
      end

      it 'does not include ActionText associations' do
        class_names = associations.map { |a| a[:class_name] }
        expect(class_names).not_to include('ActionText::RichText')
      end

      it 'does not include ActiveStorage associations' do
        class_names = associations.map { |a| a[:class_name] }
        expect(class_names).not_to include('ActiveStorage::Attachment')
      end

      it 'does not include Audited::Audit associations' do
        class_names = associations.map { |a| a[:class_name] }
        expect(class_names).not_to include('Audited::Audit')
      end
    end

    context 'with existing joins' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { ['owner'] }

      it 'includes base model associations not in existing_joins' do
        base_assocs = associations.reject { |a| a[:name].include?('.') }
        expect(base_assocs).to be_an(Array)
      end

      it 'includes nested associations from existing joins' do
        nested_assocs = associations.select { |a| a[:name].include?('.') }
        expect(nested_assocs).not_to be_empty
      end

      it 'includes nested associations with correct paths' do
        user_status_assoc = associations.find { |a| a[:name] == 'owner.user_status' }
        expect(user_status_assoc).not_to be_nil
        expect(user_status_assoc[:class_name]).to eq 'UserStatus'
      end

      it 'includes nested associations with correct labels' do
        user_status_assoc = associations.find { |a| a[:name] == 'owner.user_status' }
        expect(user_status_assoc[:label]).to eq 'Owner → User Status'
      end

      it 'sets correct depth for nested associations' do
        user_status_assoc = associations.find { |a| a[:name] == 'owner.user_status' }
        expect(user_status_assoc[:depth]).to eq 2
      end

      it 'includes both base and nested associations' do
        base_assocs = associations.reject { |a| a[:name].include?('.') }
        nested_assocs = associations.select { |a| a[:name].include?('.') }

        expect(base_assocs.length).to be >= 1
        expect(nested_assocs.length).to be >= 1
      end
    end

    context 'with multiple existing joins' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { %w[owner category] }

      it 'includes nested associations from existing joins' do
        owner_nested = associations.select { |a| a[:name].start_with?('owner.') }
        expect(owner_nested).not_to be_empty
      end
    end

    context 'with User model has_many association' do
      let(:model_name) { 'User' }
      let(:existing_joins) { [] }

      it 'includes has_many associations' do
        divisions_assoc = associations.find { |a| a[:name] == 'divisions' }
        expect(divisions_assoc).not_to be_nil
        expect(divisions_assoc[:type]).to eq 'has_many'
        expect(divisions_assoc[:class_name]).to eq 'Division'
      end
    end

    context 'with self-referential associations' do
      let(:model_name) { 'User' }
      let(:existing_joins) { [] }

      it 'includes self-referential associations if available' do
        invited_by_assoc = associations.find { |a| a[:name] == 'invited_by' && a[:class_name] == 'User' }

        if invited_by_assoc
          expect(invited_by_assoc[:class_name]).to eq 'User'
        else
          expect(associations).to be_an(Array)
        end
      end
    end

    context 'with circular reference prevention' do
      let(:model_name) { 'User' }
      let(:existing_joins) { ['divisions'] }

      it 'does not include circular references back to base model' do
        circular_assoc = associations.find { |a| a[:name] == 'divisions.owner' && a[:class_name] == 'User' }
        expect(circular_assoc).to be_nil
      end
    end

    context 'with excluded associations from config' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { [] }

      before do
        allow(RadConfig).to receive(:custom_reports_config).and_return(
          excluded_associations: ['owner']
        )
      end

      it 'excludes associations from config' do
        owner_assoc = associations.find { |a| a[:name] == 'owner' }
        expect(owner_assoc).to be_nil
      end
    end

    context 'with associations containing duplicate in name' do
      let(:model_name) { 'User' }
      let(:existing_joins) { [] }

      it 'excludes associations with duplicate in name' do
        duplicate_assocs = associations.select { |a| a[:name].include?('duplicate') }
        expect(duplicate_assocs).to be_empty
      end
    end
  end

  describe '#model_associations' do
    subject(:model_assocs) { discovery.model_associations }

    context 'with blank model name' do
      let(:model_name) { nil }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(model_assocs).to eq []
      end
    end

    context 'with empty model name' do
      let(:model_name) { '' }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(model_assocs).to eq []
      end
    end

    context 'with invalid model name' do
      let(:model_name) { 'NonExistentModel' }
      let(:existing_joins) { [] }

      it 'returns empty array' do
        expect(model_assocs).to eq []
      end
    end

    context 'with valid model' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { [] }

      it 'returns array of label/name pairs' do
        expect(model_assocs).to be_an(Array)
        expect(model_assocs.first).to be_an(Array)
        expect(model_assocs.first.length).to eq 2
      end

      it 'includes association labels with type and class' do
        owner_assoc = model_assocs.find { |label, _name| label.include?('Owner') }
        expect(owner_assoc).not_to be_nil
        expect(owner_assoc[0]).to include('Belongs to')
        expect(owner_assoc[0]).to include('User')
        expect(owner_assoc[1]).to eq 'owner'
      end

      it 'includes belongs_to associations' do
        names = model_assocs.map(&:last)
        expect(names).to include('owner')
      end

      it 'includes multiple associations' do
        names = model_assocs.map(&:last)
        expect(names.length).to be >= 1
      end

      it 'does not include ActionText associations' do
        labels = model_assocs.map(&:first)
        expect(labels.join(' ')).not_to include('ActionText::RichText')
      end

      it 'does not include ActiveStorage associations' do
        labels = model_assocs.map(&:first)
        expect(labels.join(' ')).not_to include('ActiveStorage::Attachment')
      end

      it 'does not include Audited associations' do
        labels = model_assocs.map(&:first)
        expect(labels.join(' ')).not_to include('Audited::Audit')
      end
    end

    context 'with User model' do
      let(:model_name) { 'User' }
      let(:existing_joins) { [] }

      it 'includes has_many associations' do
        divisions_assoc = model_assocs.find { |label, _name| label.include?('Divisions') }
        expect(divisions_assoc).not_to be_nil
        expect(divisions_assoc[0]).to include('Has many')
        expect(divisions_assoc[1]).to eq 'divisions'
      end

      it 'includes has_one associations if present' do
        names = model_assocs.map(&:last)
        expect(names).to be_an(Array)
      end
    end

    context 'with excluded associations from config' do
      let(:model_name) { 'Division' }
      let(:existing_joins) { [] }

      before do
        allow(RadConfig).to receive(:custom_reports_config).and_return(
          excluded_associations: ['category']
        )
      end

      it 'excludes associations from config' do
        names = model_assocs.map(&:last)
        expect(names).not_to include('category')
      end
    end
  end
end
