module Pace
  class EstimateProductCategoryJobProductType < Base
    attr_accessor :id

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :key4

    attr_accessor :key1

    attr_accessor :key2

    attr_accessor :key3

    attr_accessor :composite_product

    attr_accessor :job_product_type

    attr_accessor :estimate_product_category

    attr_accessor :questionnaire_type

    attr_accessor :estimate_variant_set


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'key4' => :'key4',
        :'key1' => :'key1',
        :'key2' => :'key2',
        :'key3' => :'key3',
        :'composite_product' => :'compositeProduct',
        :'job_product_type' => :'jobProductType',
        :'estimate_product_category' => :'estimateProductCategory',
        :'questionnaire_type' => :'questionnaireType',
        :'estimate_variant_set' => :'estimateVariantSet'
      }
    end
  end
end
