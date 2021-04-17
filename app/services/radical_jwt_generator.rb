class RadicalJwtGenerator
  attr_accessor :valid_for_minutes

  def initialize(valid_for_minutes = 5)
    @valid_for_minutes = valid_for_minutes
  end

  def token
    "Bearer #{JWT.encode(payload, secret, algorithm)}"
  end

  private

    def payload
      { exp: expires_at }
    end

    def secret
      ENV.fetch('RADICAL_JWT_SECRET')
    end

    def algorithm
      'HS256'
    end

    def expires_at
      Time.now.to_i + (valid_for_minutes * 60)
    end
end
