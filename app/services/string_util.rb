class StringUtil
  def self.integer?(string_value)
    raise 'input value is not a string' unless string_value.is_a?(String)

    /\A[-+]?\d+\z/.match(string_value).present?
  end
end
