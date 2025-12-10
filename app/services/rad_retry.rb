class RadRetryError < StandardError; end

class RadRetry
  # do not add Timeout::Error, I think this is what is used in the rake session stuff and might conflict, dunno
  # if we find we need to add the above, we can allow passing an exception to exclude to perform_request

  RESCUABLE_ERRORS = [Net::OpenTimeout, OpenURI::HTTPError, Errno::EPIPE, SocketError, OpenSSL::SSL::SSLError,
                      Errno::ENOENT, Errno::ECONNRESET, Net::ReadTimeout, Errno::ECONNREFUSED, JSON::ParserError,
                      ActiveStorage::FileNotFoundError, RadSendGridError, EOFError, Twilio::REST::TwilioError,
                      Faraday::ConnectionFailed, Faraday::TimeoutError, Faraday::SSLError, Faraday::ServerError,
                      Faraday::RackBuilder::StackLocked, Faraday::TooManyRequestsError, RadRetryError].freeze

  class << self
    def perform_request(no_delay: false, retry_count: 5, additional_errors: [], raise_original: false, &block)
      retries ||= retry_count
      block.call
    rescue *(RESCUABLE_ERRORS + additional_errors) => e
      unless (retries -= 1).positive?
        raise_original ? raise(e) : raise(RadIntermittentException, e)
      end

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
