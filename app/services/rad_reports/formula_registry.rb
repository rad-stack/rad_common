module RadReports
  class FormulaRegistry
    # Transform formulas: post-processing formatters that modify a single column's value
    # These are applied after the query returns data
    TRANSFORM_FORMULAS = {
      'UPPER' => {
        label: 'Uppercase',
        category: 'Text',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0].to_s.upcase }
      },
      'LOWER' => {
        label: 'Lowercase',
        category: 'Text',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0].to_s.downcase }
      },
      'TITLECASE' => {
        label: 'Title Case',
        category: 'Text',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0].to_s.titleize }
      },
      'CAPITALIZE' => {
        label: 'Capitalize',
        category: 'Text',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0].to_s.capitalize }
      },
      'TRUNCATE' => {
        label: 'Truncate',
        category: 'Text',
        params: [
          { name: 'length', label: 'Length', type: 'number', default: 50, col_class: 'col-6' },
          { name: 'suffix', label: 'Suffix', type: 'text', default: '...', col_class: 'col-6' }
        ],
        param_extractor: lambda { |params, value|
          [value, params['length'] || 50, params['suffix'] || '...']
        },
        executor: lambda { |args|
          length = args[1].to_i
          suffix = args[2]
          args[0].to_s.truncate(length, omission: suffix)
        }
      },
      'CONCAT' => {
        label: 'Concatenate',
        category: 'String',
        params: [
          { name: 'text', label: 'Text to append', type: 'text', default: '', placeholder: "e.g., ' - Suffix'" }
        ],
        param_extractor: ->(params, value) { [value, params['text'] || ''] },
        executor: ->(args) { args.map(&:to_s).join }
      },
      'REPLACE' => {
        label: 'Replace Text',
        category: 'String',
        params: [
          { name: 'old', label: 'Find', type: 'text', default: '', col_class: 'col-6' },
          { name: 'new', label: 'Replace with', type: 'text', default: '', col_class: 'col-6' }
        ],
        param_extractor: ->(params, value) { [value, params['old'] || '', params['new'] || ''] },
        executor: ->(args) { args[0].to_s.gsub(args[1].to_s, args[2].to_s) }
      },
      'SUBSTRING' => {
        label: 'Substring',
        category: 'String',
        params: [
          { name: 'start', label: 'Start Position', type: 'number', default: 0, col_class: 'col-6' },
          { name: 'length', label: 'Length', type: 'number', default: 10, col_class: 'col-6' }
        ],
        param_extractor: ->(params, value) { [value, params['start'] || 0, params['length']] },
        executor: lambda { |args|
          start_pos = args[1].to_i
          length = args[2]
          length.nil? ? args[0].to_s[start_pos..] : args[0].to_s[start_pos, length.to_i]
        }
      },
      'ROUND' => {
        label: 'Round',
        category: 'Math',
        params: [
          { name: 'precision', label: 'Decimal Places', type: 'number', default: 2 }
        ],
        param_extractor: ->(params, value) { [value, params['precision'] || 0] },
        executor: ->(args) { args[0].to_f.round(args[1].to_i) }
      },
      'ABS' => {
        label: 'Absolute Value',
        category: 'Math',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0].to_f.abs }
      },
      'MULTIPLY' => {
        label: 'Multiply',
        category: 'Math',
        params: [
          { name: 'factor', label: 'Multiply by', type: 'number', default: 1.0, step: 'any' }
        ],
        param_extractor: ->(params, value) { [value, params['factor'] || 1.0] },
        executor: ->(args) { args[0].to_f * args[1].to_f }
      },
      'DIVIDE' => {
        label: 'Divide',
        category: 'Math',
        params: [
          { name: 'divisor', label: 'Divide by', type: 'number', default: 1.0, step: 'any' }
        ],
        param_extractor: ->(params, value) { [value, params['divisor'] || 1.0] },
        executor: lambda { |args|
          return 0 if args[1].to_f.zero?

          args[0].to_f / args[1]
        }
      },
      'ADD' => {
        label: 'Add',
        category: 'Math',
        params: [
          { name: 'amount', label: 'Add Amount', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, value) { [value, params['amount'] || 0] },
        executor: ->(args) { args[0].to_f + args[1].to_f }
      },
      'SUBTRACT' => {
        label: 'Subtract',
        category: 'Math',
        params: [
          { name: 'amount', label: 'Subtract Amount', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, value) { [value, params['amount'] || 0] },
        executor: ->(args) { args[0].to_f - args[1].to_f }
      },
      'PERCENT' => {
        label: 'Add Percent Sign',
        category: 'Math',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { ApplicationController.helpers.number_to_percentage(args[0].to_f, precision: 2) }
      },
      'CURRENCY' => {
        label: 'Format as Currency',
        category: 'Math',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { ApplicationController.helpers.number_to_currency(args[0].to_f) }
      },
      'AGE' => {
        label: 'Calculate Age',
        category: 'Date',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: lambda { |args|
          val = args[0]
          return '' unless val.is_a?(Date) || val.is_a?(Time)

          years = ((Time.current - val.to_time) / 1.year).floor
          "#{years} years"
        }
      },
      'DAYS_AGO' => {
        label: 'Days Ago',
        category: 'Date',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: lambda { |args|
          val = args[0]
          return '' unless val.is_a?(Date) || val.is_a?(Time)

          days = ((Time.current - val.to_time) / 1.day).floor
          "#{days} days ago"
        }
      },
      'FORMAT_DATE' => {
        label: 'Format Date',
        category: 'Date',
        params: [
          {
            name: 'format',
            label: 'Format',
            type: 'select',
            default: '%m/%d/%Y',
            options: [
              ['MM/DD/YYYY', '%m/%d/%Y'],
              ['YYYY-MM-DD', '%Y-%m-%d'],
              ['Month DD, YYYY', '%B %d, %Y'],
              ['MM/DD/YY', '%m/%d/%y']
            ]
          }
        ],
        param_extractor: ->(params, value) { [value, params['format'] || '%Y-%m-%d'] },
        executor: lambda { |args|
          val = args[0]
          return '' unless val.is_a?(Date) || val.is_a?(Time)

          format = args[1]
          val.strftime(format)
        }
      },
      'BLANK' => {
        label: 'Replace if Blank',
        category: 'Logic',
        params: [
          { name: 'fallback', label: 'Fallback Value', type: 'text', default: 'N/A' }
        ],
        param_extractor: ->(params, value) { [value, params['fallback'] || ''] },
        executor: ->(args) { args[0].presence || args[1] }
      },
      'YES_NO' => {
        label: 'Yes/No',
        category: 'Logic',
        params: [],
        param_extractor: ->(_params, value) { [value] },
        executor: ->(args) { args[0] ? 'Yes' : 'No' }
      },
      'ARRAY_JOIN' => {
        label: 'Join Array',
        category: 'String',
        params: [
          { name: 'separator', label: 'Separator', type: 'text', default: ', ' }
        ],
        param_extractor: ->(params, value) { [value, params['separator'] || ', '] },
        executor: lambda { |args|
          arr = args[0]
          separator = args[1]
          return '' unless arr.is_a?(Array)

          arr.join(separator)
        }
      }
    }.freeze

    # Calculated column formulas: create entirely new columns by combining multiple columns
    # These are applied after the query returns data, combining values from multiple columns
    CALCULATED_FORMULAS = {
      'CONCAT_COLUMNS' => {
        label: 'Concatenate Columns',
        category: 'Calculated',
        is_calculated: true,
        params: [
          { name: 'columns', label: 'Columns', type: 'column_selector', default: [] },
          { name: 'separator', label: 'Separator', type: 'text', default: ' ', col_class: 'col-6' },
          { name: 'empty_replacement', label: 'Empty Value', type: 'text', default: '', col_class: 'col-6', placeholder: 'Text for empty values' }
        ],
        param_extractor: ->(params, _value, record) {
          columns = params['columns'] || []
          separator = params['separator'] || ' '
          empty_replacement = params['empty_replacement'] || ''
          [columns, separator, empty_replacement, record]
        },
        executor: lambda { |args|
          columns, separator, empty_replacement, record = args
          values = columns.map do |col_path|
            val = CalculatedColumnProcessor.extract_column_value(record, col_path)
            val.blank? ? empty_replacement : val.to_s
          end
          values.join(separator)
        }
      },
      'MULTIPLY_COLUMNS' => {
        label: 'Multiply Columns',
        category: 'Calculated',
        is_calculated: true,
        params: [
          { name: 'columns', label: 'Columns to multiply', type: 'column_selector', default: [] },
          { name: 'default_value', label: 'Default for empty', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, _value, record) {
          columns = params['columns'] || []
          default_value = (params['default_value'] || 0).to_f
          [columns, default_value, record]
        },
        executor: lambda { |args|
          columns, default_value, record = args
          result = 1.0
          columns.each do |col_path|
            val = CalculatedColumnProcessor.extract_column_value(record, col_path)
            numeric_val = val.blank? ? default_value : val.to_f
            result *= numeric_val
          end
          result
        }
      },
      'ADD_COLUMNS' => {
        label: 'Add Columns',
        category: 'Calculated',
        is_calculated: true,
        params: [
          { name: 'columns', label: 'Columns to add', type: 'column_selector', default: [] },
          { name: 'default_value', label: 'Default for empty', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, _value, record) {
          columns = params['columns'] || []
          default_value = (params['default_value'] || 0).to_f
          [columns, default_value, record]
        },
        executor: lambda { |args|
          columns, default_value, record = args
          result = 0.0
          columns.each do |col_path|
            val = CalculatedColumnProcessor.extract_column_value(record, col_path)
            numeric_val = val.blank? ? default_value : val.to_f
            result += numeric_val
          end
          result
        }
      },
      'SUBTRACT_COLUMNS' => {
        label: 'Subtract Columns (First - Others)',
        category: 'Calculated',
        is_calculated: true,
        params: [
          { name: 'columns', label: 'Columns (First - Rest)', type: 'column_selector', default: [] },
          { name: 'default_value', label: 'Default for empty', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, _value, record) {
          columns = params['columns'] || []
          default_value = (params['default_value'] || 0).to_f
          [columns, default_value, record]
        },
        executor: lambda { |args|
          columns, default_value, record = args
          return 0.0 if columns.empty?

          first_val = CalculatedColumnProcessor.extract_column_value(record, columns.first)
          result = first_val.blank? ? default_value : first_val.to_f

          columns[1..].each do |col_path|
            val = CalculatedColumnProcessor.extract_column_value(record, col_path)
            numeric_val = val.blank? ? default_value : val.to_f
            result -= numeric_val
          end
          result
        }
      },
      'DIVIDE_COLUMNS' => {
        label: 'Divide Columns (First / Second)',
        category: 'Calculated',
        is_calculated: true,
        params: [
          { name: 'columns', label: 'Columns (Dividend / Divisor)', type: 'column_selector', default: [] },
          { name: 'default_value', label: 'Default for empty', type: 'number', default: 0, step: 'any' },
          { name: 'zero_result', label: 'Result when divisor is zero', type: 'number', default: 0, step: 'any' }
        ],
        param_extractor: ->(params, _value, record) {
          columns = params['columns'] || []
          default_value = (params['default_value'] || 0).to_f
          zero_result = (params['zero_result'] || 0).to_f
          [columns, default_value, zero_result, record]
        },
        executor: lambda { |args|
          columns, default_value, zero_result, record = args
          return zero_result if columns.length < 2

          dividend_val = CalculatedColumnProcessor.extract_column_value(record, columns[0])
          divisor_val = CalculatedColumnProcessor.extract_column_value(record, columns[1])

          dividend = dividend_val.blank? ? default_value : dividend_val.to_f
          divisor = divisor_val.blank? ? default_value : divisor_val.to_f

          return zero_result if divisor.zero?

          dividend / divisor
        },
        validator: lambda { |params, errors|
          columns = params['columns']
          errors.add(:base, 'Please choose at least two columns for division') if columns.nil? || columns.length < 2
        }
      }
    }.freeze

    # Combined registry for backwards compatibility
    FORMULAS = TRANSFORM_FORMULAS.merge(CALCULATED_FORMULAS).freeze

    DEFAULT_FORMULAS = {
      'boolean' => [{ 'type' => 'YES_NO' }],
      'date' => [{ 'type' => 'FORMAT_DATE', 'params' => { 'format' => '%m/%d/%Y' } }],
      'datetime' => [{ 'type' => 'FORMAT_DATE', 'params' => { 'format' => '%m/%d/%Y' } }],
      'timestamp' => [{ 'type' => 'FORMAT_DATE', 'params' => { 'format' => '%m/%d/%Y' } }],
      'array' => [{ 'type' => 'ARRAY_JOIN', 'params' => { 'separator' => ', ' } }]
    }.freeze

    class << self
      def all
        FORMULAS
      end

      def transform_formulas
        TRANSFORM_FORMULAS
      end

      def calculated_formulas
        CALCULATED_FORMULAS
      end

      def find(type)
        FORMULAS[type]
      end

      def default_for_column_type(column_type)
        DEFAULT_FORMULAS[column_type.to_s]
      end

      def execute(type, params, value, record = nil)
        formula = find(type)
        return value unless formula

        args = if formula[:is_calculated] && record
                 formula[:param_extractor].call(params, value, record)
               else
                 formula[:param_extractor].call(params, value)
               end

        formula[:executor].call(args)
      end

      def to_json_config
        FORMULAS.transform_values { |config|
          {
            label: config[:label],
            params: config[:params]
          }
        }.to_json
      end

      def grouped_options
        transform_formulas
          .group_by { |_type, config| config[:category] }
          .transform_values { |formulas| formulas.map { |type, config| [config[:label], type] } }
      end

      def calculated_grouped_options
        calculated_formulas
          .group_by { |_type, config| config[:category] }
          .transform_values { |formulas| formulas.map { |type, config| [config[:label], type] } }
      end
    end
  end
end
