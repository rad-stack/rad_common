require 'rails_helper'

describe DatabaseUseChecker do
  describe '.generate_report' do
    let(:tables) { ['users'] }

    before { allow(described_class).to receive(:tables).and_return(tables) }

    context 'when table has more than 1 record' do
      before do
        create_list :user, 2
      end

      it 'generates a report for each table' do
        expect(described_class).to receive(:table_report)
        described_class.generate_report
      end
    end

    context 'when table has one record' do
      before do
        create :user
      end

      it 'skips table report with one record' do
        expect(described_class).not_to receive(:table_report)
        described_class.generate_report
      end
    end

    context 'when table has no records' do
      it 'skips table report and prints to console' do
        expect(described_class).not_to receive(:table_report)
        expect { described_class.generate_report }.to output("\nTable #{tables.first}\n  No Records\n").to_stdout
      end
    end
  end

  describe '.tables' do
    it 'returns an array of strings' do
      expect(described_class.tables.all? { |model| model.instance_of?(String) }).to be true
    end
  end
end
