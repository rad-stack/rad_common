class SmartyAddress
  attr_reader :lob_args

  def initialize(lob_args)
    @lob_args = parse_lob_args(lob_args)
  end

  def call
    unformatted_result = JSON.parse(lob_result).presence || {}
    SmartyResult.new(unformatted_result)
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
          auth_id = RadicalConfig.smarty_auth_id!
          auth_token = RadicalConfig.smarty_auth_token!

          credentials = SmartyStreets::StaticCredentials.new(auth_id, auth_token)

          # The appropriate license values to be used for your subscriptions
          # can be found on the Subscriptions page of the account dashboard.
          # https://www.smartystreets.com/docs/cloud/licensing
          client = SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-core-cloud']).build_us_street_api_client

          # with_proxy('localhost', 8080, 'proxyUser', 'proxyPassword'). # Uncomment this line to try it with a proxy

          lookup = SmartyStreets::USStreet::Lookup.new
          # lookup.input_id = '24601'  # Optional ID from your system
          # lookup.addressee = 'John Doe'
          lookup.street = lob_args[:primary_line]
          # lookup.street2 = 'closet under the stairs'
          lookup.secondary = lob_args[:secondary_line]
          # lookup.urbanization = ''  # Only applies to Puerto Rico addresses
          lookup.city = lob_args[:city]
          lookup.state = lob_args[:state]
          lookup.zipcode = lob_args[:zip_code]
          lookup.candidates = 1 # TODO:
          # lookup.match = Lookup.INVALID # "invalid" is the most permissive match,
          # this will always return at least one result even if the address is invalid.
          # Refer to the documentation for additional Match Strategy options.

          log_lob_request_made

          # x = client.send_lookup(lookup)

          RadicalRetry.perform_request(additional_errors: [SmartyStreets::SmartyError]) {
            # lob.us_verifications.verify(lob_args.symbolize_keys)
            client.send_lookup(lookup)
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
