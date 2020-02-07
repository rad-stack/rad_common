require 'rails_helper'
require 'csv'

RSpec.describe HerokuCommands, type: :service do
  describe 'backup' do
    it 'runs' do
      # TODO make this an actual test when time permits
      expect(described_class.backup).to be_nil
    end
  end
end
