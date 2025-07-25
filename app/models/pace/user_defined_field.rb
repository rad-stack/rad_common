module Pace
  class UserDefinedField < Base
    attr_accessor :data_object

    attr_accessor :field_type

    attr_accessor :attribute

    attr_accessor :attribute_type

    attr_accessor :description

    attr_accessor :max_length

    attr_accessor :no_max_length

    attr_accessor :required

    attr_accessor :indexed

    attr_accessor :unique_indexed

    attr_accessor :upper_case

    attr_accessor :lower_case

    attr_accessor :primary_key

    attr_accessor :parent_key

    attr_accessor :calculation

    attr_accessor :copy_during_post_convert

    attr_accessor :dispatch_changes

    attr_accessor :related_time_field

    attr_accessor :array_type

    attr_accessor :foreign_key_data_object

    attr_accessor :udl_name

    attr_accessor :syncable

    attr_accessor :display_as_headline

    attr_accessor :per_unit

    attr_accessor :has_uom

    attr_accessor :not_required_for_calculation

    attr_accessor :uomtype

    attr_accessor :uomfield


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'data_object' => :'dataObject',
        :'field_type' => :'fieldType',
        :'attribute' => :'attribute',
        :'attribute_type' => :'attributeType',
        :'description' => :'description',
        :'max_length' => :'maxLength',
        :'no_max_length' => :'noMaxLength',
        :'required' => :'required',
        :'indexed' => :'indexed',
        :'unique_indexed' => :'uniqueIndexed',
        :'upper_case' => :'upperCase',
        :'lower_case' => :'lowerCase',
        :'primary_key' => :'primaryKey',
        :'parent_key' => :'parentKey',
        :'calculation' => :'calculation',
        :'copy_during_post_convert' => :'copyDuringPostConvert',
        :'dispatch_changes' => :'dispatchChanges',
        :'related_time_field' => :'relatedTimeField',
        :'array_type' => :'arrayType',
        :'foreign_key_data_object' => :'foreignKeyDataObject',
        :'udl_name' => :'udlName',
        :'syncable' => :'syncable',
        :'display_as_headline' => :'displayAsHeadline',
        :'per_unit' => :'perUnit',
        :'has_uom' => :'hasUOM',
        :'not_required_for_calculation' => :'notRequiredForCalculation',
        :'uomtype' => :'uomtype',
        :'uomfield' => :'uomfield'
      }
    end
  end
end
