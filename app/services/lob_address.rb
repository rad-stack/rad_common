class LobAddress
  attr_reader :lob_args

  def initialize(lob_args)
    @lob_args = parse_lob_args(lob_args)
  end

  def call
    unformatted_result = JSON.parse(lob_result).presence || {}
    LobResult.new(unformatted_result)
  end

  private

    def parse_lob_args(lob_args)
      if lob_args[:zip_code].present?
        numeric_code = lob_args[:zip_code].scan(/\d+/).join
        numeric_code = '' if numeric_code.length < 5
        lob_args = lob_args.merge(zip_code: numeric_code)
      end
      lob_args
    end

    def lob_result
      @lob_result ||=
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
          lob = Lob::Client.new(api_key: RadicalConfig.lob_key!)
          log_lob_request_made

          RadicalRetry.perform_request(additional_errors: [Lob::InvalidRequestError]) {
            lob.us_verifications.verify(lob_args.symbolize_keys)
          }.to_json
        end
    end

    def cache_key
      lob_args.sort.map(&:last).join.parameterize
    end

    def log_lob_request_made
      Company.main.increment! :lob_requests_made
    end
end
