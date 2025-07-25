module Pace
  class PressEvent < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :event_type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :finishing_operation

    attr_accessor :device_capability

    attr_accessor :run_cost_per_m_basis

    attr_accessor :run_speed_adjust

    attr_accessor :run_cost_per_m

    attr_accessor :event_pass_type

    attr_accessor :use_make_ready_activity_code

    attr_accessor :setup_hours

    attr_accessor :max_run_speed

    attr_accessor :material_cost

    attr_accessor :press

    attr_accessor :make_ready_spoilage

    attr_accessor :run_spoilage

    attr_accessor :make_ready_activity_code

    attr_accessor :alt_description

    attr_accessor :run_activity_code


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'event_type' => :'eventType',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'finishing_operation' => :'finishingOperation',
        :'device_capability' => :'deviceCapability',
        :'run_cost_per_m_basis' => :'runCostPerMBasis',
        :'run_speed_adjust' => :'runSpeedAdjust',
        :'run_cost_per_m' => :'runCostPerM',
        :'event_pass_type' => :'eventPassType',
        :'use_make_ready_activity_code' => :'useMakeReadyActivityCode',
        :'setup_hours' => :'setupHours',
        :'max_run_speed' => :'maxRunSpeed',
        :'material_cost' => :'materialCost',
        :'press' => :'press',
        :'make_ready_spoilage' => :'makeReadySpoilage',
        :'run_spoilage' => :'runSpoilage',
        :'make_ready_activity_code' => :'makeReadyActivityCode',
        :'alt_description' => :'altDescription',
        :'run_activity_code' => :'runActivityCode'
      }
    end
  end
end
