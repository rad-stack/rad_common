if RadicalConfig.authy_enabled?
  Authy.api_key = RadicalConfig.authy_api_key!
  Authy.api_uri = 'https://api.authy.com/'
end
