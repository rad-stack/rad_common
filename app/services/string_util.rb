class StringUtil
  def self.integer?(string_value)
    raise 'input value is not a string' unless string_value.is_a?(String)

    /\A[-+]?\d+\z/.match(string_value).present?
  end

  def self.numeric?(string_value)
    raise 'input value is not a string' unless string_value.is_a?(String)

    begin
      true if Float(string_value)
    rescue StandardError
      false
    end
  end
end
