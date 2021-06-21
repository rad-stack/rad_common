module RadCommon
  module Sms
    module Utilities
      def self.format_twilio_number(number)
        "(#{number[2, 3]}) #{number[5, 3]}-#{number[8, 4]}"
      end
    end
  end
end
