require 'rails_helper'

RSpec.describe RadReports::FormulaRegistry, type: :service do
  describe '.all' do
    subject(:all_formulas) { described_class.all }

    it 'returns hash with all formula definitions' do
      expect(all_formulas).to be_a(Hash)
      expect(all_formulas.keys).to include('UPPER', 'TRUNCATE', 'FORMAT_DATE', 'ARRAY_JOIN')
    end
  end

  describe '.find' do
    subject(:formula) { described_class.find(type) }

    context 'with valid type' do
      let(:type) { 'UPPER' }

      it 'returns formula definition' do
        expect(formula).to be_a(Hash)
        expect(formula).to have_key(:label)
        expect(formula).to have_key(:params)
      end
    end

    context 'with invalid type' do
      let(:type) { 'INVALID' }

      it 'returns nil' do
        expect(formula).to be_nil
      end
    end
  end

  describe '.default_for_column_type' do
    it 'returns defaults for known types' do
      expect(described_class.default_for_column_type('boolean')).to eq([{ 'type' => 'YES_NO' }])
      expect(described_class.default_for_column_type('date')).to eq([{ 'type' => 'FORMAT_DATE',
                                                                       'params' => { 'format' => '%m/%d/%Y' } }])
      expect(described_class.default_for_column_type('datetime')).to eq([{ 'type' => 'FORMAT_DATE',
                                                                           'params' => { 'format' => '%m/%d/%Y' } }])
      expect(described_class.default_for_column_type('timestamp')).to eq([{ 'type' => 'FORMAT_DATE',
                                                                            'params' => { 'format' => '%m/%d/%Y' } }])
      expect(described_class.default_for_column_type('array')).to eq([{ 'type' => 'ARRAY_JOIN',
                                                                        'params' => { 'separator' => ', ' } }])
    end

    it 'returns nil for unknown types' do
      expect(described_class.default_for_column_type('foo')).to be_nil
    end
  end

  describe '.to_json_config' do
    it 'returns JSON with only label and params' do
      json = JSON.parse(described_class.to_json_config)
      expect(json).to be_a(Hash)
      expect(json['UPPER'].keys).to contain_exactly('label', 'params')
      expect(json['TRUNCATE'].keys).to contain_exactly('label', 'params')
    end
  end

  describe '.grouped_options' do
    subject(:grouped) { described_class.grouped_options }

    it 'groups formulas by category with label/type pairs' do
      expect(grouped).to be_a(Hash)
      expect(grouped['Text']).to include(%w[Uppercase UPPER])
      expect(grouped['Math']).to include(%w[Round ROUND])
    end
  end

  describe 'param extractors and executors' do
    describe 'TRUNCATE' do
      let(:formula) { described_class.find('TRUNCATE') }

      it 'extracts defaults when params missing' do
        args = formula[:param_extractor].call({}, 'A long message here')
        expect(args).to eq(['A long message here', 50, '...'])
      end

      it 'truncates with custom length and suffix' do
        params = { 'length' => 10, 'suffix' => '..' }
        args = formula[:param_extractor].call(params, 'abcdefghijklmnop')
        expect(formula[:executor].call(args)).to eq('abcdefgh..')
      end
    end

    describe 'SUBSTRING' do
      let(:formula) { described_class.find('SUBSTRING') }

      it 'extracts with defaults and slices to end when length is nil' do
        params = { 'start' => 2 } # no length provided
        args = formula[:param_extractor].call(params, 'rad_common')
        expect(args).to eq(['rad_common', 2, nil])
        expect(formula[:executor].call(args)).to eq('d_common')
      end

      it 'slices with explicit start and length' do
        params = { 'start' => 4, 'length' => 3 }
        args = formula[:param_extractor].call(params, 'rad_common')
        expect(formula[:executor].call(args)).to eq('com')
      end
    end

    describe 'DIVIDE' do
      let(:formula) { described_class.find('DIVIDE') }

      it 'returns 0 when divisor is zero' do
        args = formula[:param_extractor].call({ 'divisor' => 0 }, 123)
        expect(formula[:executor].call(args)).to eq(0)
      end

      it 'divides by provided divisor' do
        args = formula[:param_extractor].call({ 'divisor' => 4 }, 12)
        expect(formula[:executor].call(args)).to eq(3.0)
      end
    end

    describe 'FORMAT_DATE' do
      let(:formula) { described_class.find('FORMAT_DATE') }

      it 'uses provided format' do
        date = Date.new(2024, 1, 2)
        args = formula[:param_extractor].call({ 'format' => '%Y-%m-%d' }, date)
        expect(formula[:executor].call(args)).to eq('2024-01-02')
      end

      it 'returns empty string for non-date input' do
        args = formula[:param_extractor].call({ 'format' => '%m/%d/%Y' }, 'not a date')
        expect(formula[:executor].call(args)).to eq('')
      end
    end

    describe 'ARRAY_JOIN' do
      let(:formula) { described_class.find('ARRAY_JOIN') }

      it 'joins array with default separator' do
        args = formula[:param_extractor].call({}, %w[a b c])
        expect(formula[:executor].call(args)).to eq('a, b, c')
      end

      it 'returns empty string when value is not an array' do
        args = formula[:param_extractor].call({}, 'abc')
        expect(formula[:executor].call(args)).to eq('')
      end
    end
  end

  describe '.execute' do
    subject(:exec) { described_class.execute(type, params, value) }

    context 'when text transformations' do
      it 'uppercases text' do
        type = 'UPPER'
        expect(described_class.execute(type, {}, 'rad')).to eq('RAD')
      end

      it 'lowercases text' do
        expect(described_class.execute('LOWER', {}, 'Rad')).to eq('rad')
      end

      it 'titleizes text' do
        expect(described_class.execute('TITLECASE', {}, 'hello world')).to eq('Hello World')
      end

      it 'capitalizes text' do
        expect(described_class.execute('CAPITALIZE', {}, 'hello')).to eq('Hello')
      end
    end

    context 'when math operations' do
      it 'rounds to precision' do
        expect(described_class.execute('ROUND', { 'precision' => 2 }, 3.14159)).to eq(3.14)
      end

      it 'absolute value' do
        expect(described_class.execute('ABS', {}, -5)).to eq(5.0)
      end

      it 'multiply' do
        expect(described_class.execute('MULTIPLY', { 'factor' => 2.5 }, 4)).to eq(10.0)
      end

      it 'add and subtract' do
        expect(described_class.execute('ADD', { 'amount' => 3 }, 7)).to eq(10.0)
        expect(described_class.execute('SUBTRACT', { 'amount' => 4 }, 7)).to eq(3.0)
      end

      it 'percent' do
        expect(described_class.execute('PERCENT', {}, 12)).to eq('12.00%')
      end
    end

    context 'when string operations' do
      it 'concatenates' do
        expect(described_class.execute('CONCAT', { 'text' => ' - done' }, 'task')).to eq('task - done')
      end

      it 'replaces text' do
        expect(described_class.execute('REPLACE', { 'old' => 'a', 'new' => 'o' }, 'radstack')).to eq('rodstock')
      end
    end

    context 'when date operations' do
      let(:fixed_time) { Time.zone.parse('2024-10-01 12:00:00 UTC') }

      before do
        allow(Time).to receive(:current).and_return(fixed_time)
      end

      it 'calculates age in years from Date' do
        dob = Date.new(2000, 9, 30)
        expect(described_class.execute('AGE', {}, dob)).to eq('24 years')
      end

      it 'returns empty string for AGE when not a date' do
        expect(described_class.execute('AGE', {}, 'n/a')).to eq('')
      end

      it 'returns days ago' do
        two_days_ago = fixed_time - 2.days
        expect(described_class.execute('DAYS_AGO', {}, two_days_ago)).to eq('2 days ago')
      end

      it 'formats date with default param' do
        date = Date.new(2024, 1, 2)
        expect(described_class.execute('FORMAT_DATE', { 'format' => '%m/%d/%Y' }, date)).to eq('01/02/2024')
      end
    end

    context 'when logic operations' do
      it 'replaces blank with fallback' do
        expect(described_class.execute('BLANK', { 'fallback' => 'N/A' }, '')).to eq('N/A')
        expect(described_class.execute('BLANK', { 'fallback' => 'N/A' }, 'value')).to eq('value')
      end

      it 'converts boolean to Yes/No' do
        expect(described_class.execute('YES_NO', {}, true)).to eq('Yes')
        expect(described_class.execute('YES_NO', {}, false)).to eq('No')
        expect(described_class.execute('YES_NO', {}, nil)).to eq('No')
      end
    end
  end
end
