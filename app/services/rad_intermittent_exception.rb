class RadIntermittentException < StandardError
  def initialize(message = 'HTTP request failed')
    super
  end
end
