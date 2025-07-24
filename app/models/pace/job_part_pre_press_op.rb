module Pace
  class JobPartPrePressOp < Base
    attr_accessor :id

    attr_accessor :state

    attr_accessor :size

    attr_accessor :hours

    attr_accessor :description

    attr_accessor :component

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :unit_label

    attr_accessor :job_part_key

    attr_accessor :estimate_source

    attr_accessor :job_part

    attr_accessor :job

    attr_accessor :sequence

    attr_accessor :quantity

    attr_accessor :manual

    attr_accessor :customer_viewable

    attr_accessor :size_height_display_uom

    attr_accessor :size_width_display_uom

    attr_accessor :size_height

    attr_accessor :size_width

    attr_accessor :num_out

    attr_accessor :prepress_item

    attr_accessor :prep_activity

    attr_accessor :ganged

    attr_accessor :output_resource_id

    attr_accessor :process_status

    attr_accessor :queue_entry_id


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'state' => :'state',
        :'size' => :'size',
        :'hours' => :'hours',
        :'description' => :'description',
        :'component' => :'component',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'unit_label' => :'unitLabel',
        :'job_part_key' => :'jobPartKey',
        :'estimate_source' => :'estimateSource',
        :'job_part' => :'jobPart',
        :'job' => :'job',
        :'sequence' => :'sequence',
        :'quantity' => :'quantity',
        :'manual' => :'manual',
        :'customer_viewable' => :'customerViewable',
        :'size_height_display_uom' => :'sizeHeightDisplayUOM',
        :'size_width_display_uom' => :'sizeWidthDisplayUOM',
        :'size_height' => :'sizeHeight',
        :'size_width' => :'sizeWidth',
        :'num_out' => :'numOut',
        :'prepress_item' => :'prepressItem',
        :'prep_activity' => :'prepActivity',
        :'ganged' => :'ganged',
        :'output_resource_id' => :'outputResourceID',
        :'process_status' => :'processStatus',
        :'queue_entry_id' => :'queueEntryID'
      }
    end
  end
end
