class SmartyAddress
  attr_reader :address_args

  def initialize(address_args)
    @address_args = parse_address_args(address_args)
  end

  def call
    unformatted_result = JSON.parse(api_result).presence || {}
    SmartyResult.new(unformatted_result)
  end

  private

    def parse_address_args(address_args)
      if address_args[:zip_code].present?
        numeric_code = address_args[:zip_code].scan(/\d+/).join
        numeric_code = '' if numeric_code.length < 5
        address_args = address_args.merge(zip_code: numeric_code)
      end

      address_args
    end

    def api_result
      @api_result ||=
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
          lookup.street = address_args[:primary_line]
          # lookup.street2 = 'closet under the stairs'
          lookup.secondary = address_args[:secondary_line]
          # lookup.urbanization = ''  # Only applies to Puerto Rico addresses
          lookup.city = address_args[:city]
          lookup.state = address_args[:state]
          lookup.zipcode = address_args[:zip_code]
          lookup.candidates = 1 # TODO:
          # lookup.match = Lookup.INVALID # "invalid" is the most permissive match,
          # this will always return at least one result even if the address is invalid.
          # Refer to the documentation for additional Match Strategy options.

          log_request_made

          RadicalRetry.perform_request(additional_errors: [SmartyStreets::SmartyError]) {
            client.send_lookup(lookup)
          }.to_json
        end
    end

    def cache_key
      address_args.sort.map(&:last).join.parameterize
    end

    def log_request_made
      Company.main.increment! :address_requests_made
    end
end
