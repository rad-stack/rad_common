module Pace
  class TodoItemClosure < Base
    attr_accessor :id

    attr_accessor :attachments

    attr_accessor :note

    attr_accessor :shipment_completion_time

    attr_accessor :job_cost_notes


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'Id',
        :'attachments' => :'Attachments',
        :'note' => :'Note',
        :'shipment_completion_time' => :'ShipmentCompletionTime',
        :'job_cost_notes' => :'JobCostNotes'
      }
    end
  end
end
