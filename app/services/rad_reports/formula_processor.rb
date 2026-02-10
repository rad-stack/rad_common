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

        result = FormulaRegistry.execute(type, params, result, record)
      end

      result
    end
  end
end
