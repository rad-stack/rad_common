module ApiLogsHelper
  def api_log_show_data(api_log)
    items = [{ label: 'Service Name', value: api_log.service_name },
             { label: 'HTTP Method', value: api_log.http_method },
             { label: 'URL', value: api_log.url },
             { label: 'Response Status', value: api_log.response_status },
             { label: 'Success', value: format_boolean(api_log.success) },
             { label: 'Duration', value: api_log.duration_ms.present? ? "#{api_log.duration_ms} ms" : nil },
             { label: 'Credential Key Name', value: api_log.credential_key_name },
             { label: 'Error Message', value: api_log.error_message }]

    items.reject { |item| item.is_a?(Hash) && item[:value].blank? }
  end
end
