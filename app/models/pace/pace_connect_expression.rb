module Pace
  class PaceConnectExpression < Base
    attr_accessor :name

    attr_accessor :length

    attr_accessor :id

    attr_accessor :active

    attr_accessor :node_type

    attr_accessor :attribute_name

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :data_type

    attr_accessor :pace_connect_generated

    attr_accessor :pace_connect

    attr_accessor :pace_connect_generated_id

    attr_accessor :expression_type

    attr_accessor :job_part_item_expression

    attr_accessor :job_material_expression

    attr_accessor :node_action

    attr_accessor :pace_connect_expression

    attr_accessor :vertex_attribute

    attr_accessor :change_order_line_expression

    attr_accessor :invoice_tax_dist_expression

    attr_accessor :smart_works_order_ack_attributes

    attr_accessor :jde_lansa_attributes

    attr_accessor :invoice_line_expression

    attr_accessor :job_shipment_expression

    attr_accessor :job_expression

    attr_accessor :name_space_uri

    attr_accessor :job_part_expression

    attr_accessor :job_part_press_form_expression

    attr_accessor :great_plains_attributes

    attr_accessor :perfecta_attributes

    attr_accessor :external_xpath_expression

    attr_accessor :name_space_prefix

    attr_accessor :job_product_expression

    attr_accessor :job_contact_expression

    attr_accessor :inventory_item_expression

    attr_accessor :carton_expression

    attr_accessor :invoice_extra_expression

    attr_accessor :smart_works_order_asn_attributes

    attr_accessor :job_plan_expression

    attr_accessor :customer_expression

    attr_accessor :invoice_expression

    attr_accessor :job_part_pre_press_op_expression


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'length' => :'length',
        :'id' => :'id',
        :'active' => :'active',
        :'node_type' => :'nodeType',
        :'attribute_name' => :'attributeName',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'data_type' => :'dataType',
        :'pace_connect_generated' => :'paceConnectGenerated',
        :'pace_connect' => :'paceConnect',
        :'pace_connect_generated_id' => :'paceConnectGeneratedID',
        :'expression_type' => :'expressionType',
        :'job_part_item_expression' => :'jobPartItemExpression',
        :'job_material_expression' => :'jobMaterialExpression',
        :'node_action' => :'nodeAction',
        :'pace_connect_expression' => :'paceConnectExpression',
        :'vertex_attribute' => :'vertexAttribute',
        :'change_order_line_expression' => :'changeOrderLineExpression',
        :'invoice_tax_dist_expression' => :'invoiceTaxDistExpression',
        :'smart_works_order_ack_attributes' => :'smartWorksOrderAckAttributes',
        :'jde_lansa_attributes' => :'jdeLansaAttributes',
        :'invoice_line_expression' => :'invoiceLineExpression',
        :'job_shipment_expression' => :'jobShipmentExpression',
        :'job_expression' => :'jobExpression',
        :'name_space_uri' => :'nameSpaceURI',
        :'job_part_expression' => :'jobPartExpression',
        :'job_part_press_form_expression' => :'jobPartPressFormExpression',
        :'great_plains_attributes' => :'greatPlainsAttributes',
        :'perfecta_attributes' => :'perfectaAttributes',
        :'external_xpath_expression' => :'externalXpathExpression',
        :'name_space_prefix' => :'nameSpacePrefix',
        :'job_product_expression' => :'jobProductExpression',
        :'job_contact_expression' => :'jobContactExpression',
        :'inventory_item_expression' => :'inventoryItemExpression',
        :'carton_expression' => :'cartonExpression',
        :'invoice_extra_expression' => :'invoiceExtraExpression',
        :'smart_works_order_asn_attributes' => :'smartWorksOrderAsnAttributes',
        :'job_plan_expression' => :'jobPlanExpression',
        :'customer_expression' => :'customerExpression',
        :'invoice_expression' => :'invoiceExpression',
        :'job_part_pre_press_op_expression' => :'jobPartPrePressOpExpression'
      }
    end
  end
end
