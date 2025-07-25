module Pace
  class EstimatePartContentFile < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :content_file_category

    attr_accessor :origin

    attr_accessor :content_file

    attr_accessor :metrix_cutter_operations

    attr_accessor :sequence

    attr_accessor :estimate_part

    attr_accessor :unmapped_metrix_cutter_operations


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'content_file_category' => :'contentFileCategory',
        :'origin' => :'origin',
        :'content_file' => :'contentFile',
        :'metrix_cutter_operations' => :'metrixCutterOperations',
        :'sequence' => :'sequence',
        :'estimate_part' => :'estimatePart',
        :'unmapped_metrix_cutter_operations' => :'unmappedMetrixCutterOperations'
      }
    end
  end
end
