class ApiLog < ApplicationRecord
  SENSITIVE_PATTERNS = /authorization|token|api[_-]?key|password|secret|credential|bearer/i

  scope :sorted, -> { order(created_at: :desc, id: :desc) }

  validates :service_name, presence: true
  validates :http_method, presence: true
  validates :url, presence: true

  strip_attributes

  def to_s
    "#{service_name} #{http_method} #{response_status}"
  end

  def table_row_style
    return 'table-danger' unless success?
  end

  def self.sanitize_headers(headers)
    return if headers.blank?

    headers = headers.to_h if headers.respond_to?(:to_h) && !headers.is_a?(Hash)
    return headers unless headers.is_a?(Hash)

    headers.transform_keys(&:to_s).each_with_object({}) do |(key, value), sanitized|
      sanitized[key] = if key.match?(SENSITIVE_PATTERNS)
                         '[FILTERED]'
                       elsif value.is_a?(Hash)
                         sanitize_headers(value)
                       else
                         value
                       end
    end
  end

  def self.truncate_body(body)
    return if body.blank?
    return body if body.is_a?(Hash)

    parsed = JSON.parse(body)
    parsed
  rescue JSON::ParserError
    body.to_s.truncate(10_000)
  end
end
