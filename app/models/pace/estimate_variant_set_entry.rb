module Pace
  class EstimateVariantSetEntry < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :composite_product

    attr_accessor :job_product_type

    attr_accessor :est_variant_set


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'composite_product' => :'compositeProduct',
        :'job_product_type' => :'jobProductType',
        :'est_variant_set' => :'estVariantSet'
      }
    end
  end
end
