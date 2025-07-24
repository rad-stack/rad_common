module Pace
  class TemporalUnit < Base
    attr_accessor :date_based

    attr_accessor :time_based

    attr_accessor :duration

    attr_accessor :duration_estimated


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'date_based' => :'dateBased',
        :'time_based' => :'timeBased',
        :'duration' => :'duration',
        :'duration_estimated' => :'durationEstimated'
      }
    end
  end
end
