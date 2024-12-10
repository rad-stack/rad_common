class SmartyAddress
  attr_reader :address_args

  def initialize(address_args)
    @address_args = parse_address_args(address_args)
  end

  def call
    SmartyResult.new(api_result, zip4_provided?)
  end

  private

    def parse_address_args(address_args)
      if address_args[:zipcode].present?
        numeric_code = address_args[:zipcode].scan(/\d+/).join
        numeric_code = '' if numeric_code.length < 5
        address_args = address_args.merge(zipcode: numeric_code)
      end

      address_args
    end

    def zip4_provided?
      address_args[:zipcode].present? && address_args[:zipcode].size == 9
    end

    def api_result
      @api_result ||=
        Rails.cache.fetch(cache_key, expires_in: 1.day) do
          lookup = SmartyStreets::USStreet::Lookup.new

          lookup.street = address_args[:address_1]
          lookup.secondary = address_args[:address_2]
          lookup.city = address_args[:city]
          lookup.state = address_args[:state]
          lookup.zipcode = address_args[:zipcode]
          lookup.candidates = 1
          lookup.match = SmartyStreets::USStreet::MatchType::ENHANCED

          log_request_made

          RadicalRetry.perform_request(additional_errors: [SmartyStreets::SmartyError]) { client.send_lookup(lookup) }
        end
    end

    def cache_key
      address_args.sort.map(&:last).join.parameterize
    end

    def log_request_made
      Company.main.increment! :address_requests_made
    end

    def client
      SmartyStreets::ClientBuilder.new(credentials).with_licenses(['us-core-cloud']).build_us_street_api_client
    end

    def credentials
      SmartyStreets::StaticCredentials.new(RadConfig.smarty_auth_id!, RadConfig.smarty_auth_token!)
    end
end
