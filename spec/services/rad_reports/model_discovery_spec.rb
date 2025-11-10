require 'rails_helper'

RSpec.describe RadReports::ModelDiscovery, type: :service do
  describe '.available_models' do
    subject(:models) { described_class.available_models }

    it 'returns array of label/name pairs' do
      expect(models).to be_an(Array)
      expect(models.first).to be_an(Array)
      expect(models.first.length).to eq 2
    end

    it 'includes known models' do
      model_names = models.map(&:last)
      expect(model_names).to include('User')
      expect(model_names).to include('Division')
    end

    it 'excludes default excluded models' do
      model_names = models.map(&:last)
      expect(model_names).not_to include('ContactLog')
      expect(model_names).not_to include('SystemMessage')
      expect(model_names).not_to include('SecurityRole')
    end

    it 'sorts results alphabetically by label' do
      labels = models.map(&:first)
      expect(labels).to eq labels.sort
    end
  end

  describe '.available_model_names' do
    subject(:model_names) { described_class.available_model_names }

    it 'returns array of model name strings' do
      expect(model_names).to be_an(Array)
      expect(model_names.first).to be_a(String)
    end

    it 'includes known models' do
      expect(model_names).to include('User')
      expect(model_names).to include('Division')
    end
  end

  describe '.model_available?' do
    subject(:available) { described_class.model_available?(model) }

    context 'with string model name' do
      let(:model) { 'User' }

      it 'returns true for available model' do
        expect(available).to be true
      end
    end

    context 'with model class' do
      let(:model) { User }

      it 'returns true for available model' do
        expect(available).to be true
      end
    end

    context 'with excluded model' do
      let(:model) { 'SecurityRole' }

      it 'returns false' do
        expect(available).to be false
      end
    end

    context 'with non-existent model' do
      let(:model) { 'NonExistentModel' }

      it 'returns false' do
        expect(available).to be false
      end
    end
  end
end
