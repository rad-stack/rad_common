class RadicalSendGrid
  def self.send_grid_enabled?
    Rails.application.credentials.sendgrid.present? && Rails.application.credentials.sendgrid[:api_key].present?
  end

  def validate_email(email)
    return unless RadicalSendGrid.send_grid_enabled?

    response = RadicalRetry.perform_request(retry_count: 2) do
      inner_response = client._('validations/email').post(request_body: "{\"email\":\"#{email}\"}")
      raise RadicalSendGridError, inner_response.body unless inner_response.status_code == '200'

      inner_response
    end

    if response.parsed_body[:result][:verdict] == 'Invalid'
      Rails.logger.info "SendGrid email validation result: #{response.body}"

      # TODO: maybe check Risky verdicts as well
      return 'does not appear to be a valid email address'
    end

    nil
  end

  private

    def client
      SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key]).client
    end
end
