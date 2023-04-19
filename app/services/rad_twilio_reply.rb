class RadTwilioReply
  attr_accessor :params

  def initialize(params)
    self.params = params
  end

  def process!; end

  def valid?
    params[:Body].present? && params[:From].present?
  end

  private

    def phone_number
      format_twilio_number(params[:From])
    end

    def format_twilio_number(number)
      "(#{number[2, 3]}) #{number[5, 3]}-#{number[8, 4]}"
    end
end
