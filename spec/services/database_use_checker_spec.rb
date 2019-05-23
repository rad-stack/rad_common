require 'rails_helper'

describe DatabaseUseChecker do
  describe '.generate_report' do
    let(:tables) { ['users'] }

    before do
      expect(described_class).to receive(:tables).and_return(tables)
    end

    context 'table has more than 1 record' do
      before do
        create_list(:user, 2)
      end

      it 'generates a report for each table' do
        expect(described_class).to receive(:table_report)
        described_class.generate_report
      end
    end

    context 'table has one record' do
      before do
        create(:user)
      end

      it 'skips table report with one record' do
        expect(described_class).not_to receive(:table_report)
        described_class.generate_report
      end
    end

    context 'table has no records' do
      it 'skips table report and prints to console' do
        expect(described_class).not_to receive(:table_report)
        expect { described_class.generate_report }.to output("Table #{tables.first}\n  No Records\n").to_stdout
      end
    end
  end

  describe '.tables' do
    it 'returns an array of strings' do
      expect(described_class.tables.all? { |model| model.class == String }).to eq true
    end
  end

  describe '.table_report' do
    let(:table_name) { 'users' }
    let(:column_name) { 'email' }

    before do
      expect(described_class).to receive(:table_columns).with(table_name).and_return([column_name]).at_least(:once)
      allow(ActiveRecord::Base.connection).to receive_message_chain(:execute, :values, :flatten).and_return(values)
    end

    context 'all values are blank' do
      let(:values) { ['', nil] }

      it 'prints to the console' do
        expect { described_class.table_report(table_name) }.to output("Table #{table_name}\n  Blank: #{table_name}##{column_name}\n").to_stdout
      end
    end

    context 'all values are not blank' do
      let(:values) { ['foo', nil, '', 'bar'] }

      it 'does not print column info to the console' do
        expect { described_class.table_report(table_name) }.not_to output.to_stdout
      end
    end

    context 'all values are the same' do
      let(:values) { ['foobar'] }

      it 'prints column info to the console' do
        expect { described_class.table_report(table_name) }.to output("Table #{table_name}\n  Identical Values: #{table_name}##{column_name}\n").to_stdout
      end

      it 'prints the table name' do
        allow(described_class).to receive(:review_column).and_return(nil)

        expect { described_class.table_report(table_name) }.to output("Table #{table_name}\n").to_stdout
      end
    end

    context 'all values are not the same' do
      let(:values) { %w[foo bar] }

      it 'does not print anything to console' do
        expect { described_class.table_report(table_name) }.not_to output.to_stdout
      end
    end
  end
end
