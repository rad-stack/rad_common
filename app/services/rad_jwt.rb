require 'jwt'

class RadJwt
  BITS_IN_BYTE = 8
  MINIMUM_SECRET_BIT_SIZE = 256
  JWT_ALGORITHM = 'HS256'.freeze
  def initialize
    validate_key!
  end

  def encode(payload)
    JWT.encode payload, RadConfig.jwt_secret!, JWT_ALGORITHM
  end

  def decode(token)
    JWT.decode token, RadConfig.jwt_secret!, true
  end

  def generate_token(valid_for_minutes = 5)
    expires_at = Time.now.to_i + (valid_for_minutes * 60)
    encode({ exp: expires_at })
  end

  private

    def validate_key!
      bit_size = RadConfig.jwt_secret!.bytesize * BITS_IN_BYTE
      raise 'JWT secret must be at least 256 bits' if bit_size < MINIMUM_SECRET_BIT_SIZE
    end
end
