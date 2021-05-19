class RadicalSendGrid
  def self.send_grid_enabled?
    ENV['SEND_GRID_API_KEY'].present?
  end

  def validate_email(email)
    return unless RadicalSendGrid.send_grid_enabled?

    response = RadicalRetry.perform_request(retry_count: 2) do
      client._('validations/email').post(request_body: "{\"email\":\"#{email}\"}")
    end

    # TODO: handle this better, can wait for it to crash first
    raise response.body unless response.status_code == '200'

    if response.parsed_body[:result][:verdict] == 'Invalid'
      # TODO: maybe check Risky verdicts as well
      return 'does not appear to be a valid email address'
    end

    nil
  end

  private

    def client
      SendGrid::API.new(api_key: ENV.fetch('SEND_GRID_API_KEY')).client
    end
end
