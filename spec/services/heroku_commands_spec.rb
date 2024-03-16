require 'rails_helper'

describe HerokuCommands do
  before { allow(described_class).to receive(:dbname).and_return 'rad_common_development' }

  describe 'backup' do
    xit 'runs without exception' do
      expect(described_class.backup('radstack-staging')).to be_nil
    end
  end

  describe 'restore_from_backup' do
    it 'runs without exception' do
      expect(described_class.restore_from_backup('spec/fixtures/db.dump')).to be_nil
    end
  end

  describe 'dump' do
    it 'runs without exception' do
      expect(described_class.dump).to be_nil
    end
  end

  describe 'clone' do
    xit 'runs without exception' do
      expect(described_class.clone('radstack-staging', 'foo')).to be_nil
    end
  end

  describe 'reset_staging' do
    xit 'runs without exception' do
      expect(described_class.reset_staging('radstack-staging')).to be_nil
    end
  end

  describe 'copy_production_data' do
    xit 'runs without exception' do
      expect(described_class.copy_production_data('radstack-staging',
                                                  'radstack-staging')).to be_nil
    end
  end
end
