module RadReports
  class FormulaProcessor
    def self.call(formula, value, record = nil)
      return value if formula.blank?
      return value unless formula.is_a?(Array)

      apply_transforms(formula, value, record)
    rescue StandardError => e
      Sentry.capture_exception(e)
      value
    end

    def self.apply_transforms(transforms, value, record)
      result = value

      transforms.each do |transform|
        type = transform['type']
        params = transform['params'] || {}

        args = convert_params_to_args(type, params, result)
        result = execute_function(type.upcase, args, result, record)
      end

      result
    end

    def self.convert_params_to_args(type, params, value)
      args = [value]

      case type.upcase
      when 'TRUNCATE'
        args << (params['length'] || 50)
        args << (params['suffix'] || '...')
      when 'CONCAT'
        args << (params['text'] || '')
      when 'REPLACE'
        args << (params['old'] || '')
        args << (params['new'] || '')
      when 'SUBSTRING'
        args << (params['start'] || 0)
        args << params['length']
      when 'ROUND'
        args << (params['precision'] || 0)
      when 'MULTIPLY'
        args << (params['factor'] || 1.0)
      when 'DIVIDE'
        args << (params['divisor'] || 1.0)
      when 'ADD', 'SUBTRACT'
        args << (params['amount'] || 0)
      when 'FORMAT_DATE'
        args << (params['format'] || '%Y-%m-%d')
      when 'BLANK'
        args << (params['fallback'] || '')
      end

      args
    end

    private_class_method def self.execute_function(function_name, args, value, _record)
      case function_name
      # Text transformations
      when 'UPPER'
        args[0].to_s.upcase
      when 'LOWER'
        args[0].to_s.downcase
      when 'TITLECASE', 'TITLE'
        args[0].to_s.titleize
      when 'CAPITALIZE'
        args[0].to_s.capitalize
      when 'TRUNCATE'
        length = args[1] || 50
        suffix = args[2] || '...'
        # Don't use separator - it prevents truncation at exact length
        args[0].to_s.truncate(length.to_i, omission: suffix)

      # String operations
      when 'CONCAT'
        args.map(&:to_s).join
      when 'REPLACE'
        args[0].to_s.gsub(args[1].to_s, args[2].to_s)
      when 'SUBSTRING', 'SUBSTR'
        start_pos = args[1].to_i
        length = args[2]
        length.nil? ? args[0].to_s[start_pos..] : args[0].to_s[start_pos, length.to_i]

      # Math operations
      when 'ROUND'
        precision = args[1] || 0
        args[0].to_f.round(precision.to_i)
      when 'ABS'
        args[0].to_f.abs
      when 'MULTIPLY'
        args[0].to_f * args[1].to_f
      when 'DIVIDE'
        return 0 if args[1].to_f.zero?

        args[0].to_f / args[1].to_f
      when 'ADD'
        args[0].to_f + args[1].to_f
      when 'SUBTRACT'
        args[0].to_f - args[1].to_f
      when 'PERCENT'
        "#{args[0].to_f}%"

      # Conditional logic
      when 'BLANK'
        fallback = args[1] || ''
        args[0].presence || fallback

      # Date operations
      when 'AGE'
        val = args[0]
        return '' unless val.is_a?(Date) || val.is_a?(Time)

        years = ((Time.current - val.to_time) / 1.year).floor
        "#{years} years"
      when 'DAYS_AGO'
        val = args[0]
        return '' unless val.is_a?(Date) || val.is_a?(Time)

        days = ((Time.current - val.to_time) / 1.day).floor
        "#{days} days ago"
      when 'FORMAT_DATE'
        val = args[0]
        return '' unless val.is_a?(Date) || val.is_a?(Time)

        format = args[1] || '%Y-%m-%d'
        val.strftime(format)

      # Boolean operations
      when 'YES_NO'
        args[0] ? 'Yes' : 'No'

      else
        value
      end
    end
  end
end
