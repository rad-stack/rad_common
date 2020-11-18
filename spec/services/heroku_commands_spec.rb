require 'rails_helper'
require 'csv'

RSpec.describe HerokuCommands, type: :service do
  before { allow(described_class).to receive(:dbname).and_return 'foo' }

  describe 'backup' do
    it 'runs' do
      # TODO: make this an actual test when time permits
      expect(described_class.backup).to be_nil
    end
  end

  describe 'restore_from_backup' do
    it 'runs' do
      # TODO: make this an actual test when time permits
      expect(described_class.restore_from_backup('foo')).to be_nil
    end
  end

  describe 'dump' do
    after { FileUtils.rm 'your_data.dump' }

    it 'runs' do
      # TODO: make this an actual test when time permits
      expect(described_class.dump).to be_nil
    end
  end

  describe 'clone' do
    it 'runs' do
      # TODO: make this an actual test when time permits
      expect(described_class.clone).to be_nil
    end
  end
end
