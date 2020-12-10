class RadicalRetry
  # do not add Timeout::Error, I think this is what is used in the rake session stuff and might conflict, dunno
  # do not add Twilio::REST::TwilioError, else the SMS sender error handling won't work
  # if we find we need to add the above, we can allow passing an exception to exclude to perform_request

  RESCUABLE_ERRORS = [Net::OpenTimeout, OpenURI::HTTPError, HTTPClient::ConnectTimeoutError, Errno::EPIPE, SocketError,
                      OpenSSL::SSL::SSLError, Errno::ENOENT, Errno::ECONNRESET, Net::ReadTimeout, Errno::ECONNREFUSED,
                      ActiveStorage::FileNotFoundError, HTTPClient::ReceiveTimeoutError].freeze

  class << self
    def perform_request(no_delay: false, retry_count: 5, additional_errors: [], &block)
      retries ||= retry_count
      block.call
    rescue *(RESCUABLE_ERRORS + additional_errors) => e
      raise RadicallyIntermittentException, e unless (retries -= 1).positive?

      exponential_pause(retries, no_delay)
      retry
    end
    alias try perform_request

    private

      WAIT_TIMES = [2, 4, 8, 16, 32, 64].freeze

      def exponential_pause(attempts, no_delay)
        return 0 if no_delay

        seconds = WAIT_TIMES[attempts - 1] || 64
        sleep(seconds)
      end
  end
end
