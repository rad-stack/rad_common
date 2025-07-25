module Pace
  class SYAuditLog < Base
    attr_accessor :key

    attr_accessor :object

    attr_accessor :attribute

    attr_accessor :date

    attr_accessor :username

    attr_accessor :schema

    attr_accessor :current_value

    attr_accessor :prior_value

    attr_accessor :transaction_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'key' => :'key',
        :'object' => :'object',
        :'attribute' => :'attribute',
        :'date' => :'date',
        :'username' => :'username',
        :'schema' => :'schema',
        :'current_value' => :'currentValue',
        :'prior_value' => :'priorValue',
        :'transaction_id' => :'transactionId'
      }
    end
  end
end
