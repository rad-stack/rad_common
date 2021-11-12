require 'rails_helper'

RSpec.describe SecurityRole, type: :model do
  describe 'seed_items' do
    it 'runs without error' do
      expect(described_class.seed_items).to eq true
    end
  end
end
