require 'jwt'

class RadJwtGenerator
  JWT_ALGORITHM = 'HS256'.freeze

  attr_accessor :valid_for_minutes

  def initialize(valid_for_minutes = 5)
    @valid_for_minutes = valid_for_minutes
  end

  def token
    JWT.encode payload, secret, JWT_ALGORITHM
  end

  private

    def payload
      { exp: expires_at }
    end

    def secret
      RadConfig.jwt_secret!
    end

    def expires_at
      Time.now.to_i + (valid_for_minutes * 60)
    end
end
