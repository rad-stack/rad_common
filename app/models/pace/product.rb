module Pace
  class Product < Base
    attr_accessor :fields

    attr_accessor :id

    attr_accessor :active

    attr_accessor :version

    attr_accessor :caption15

    attr_accessor :description

    attr_accessor :caption6

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sales_category

    attr_accessor :item_template

    attr_accessor :caption1

    attr_accessor :data_type8

    attr_accessor :data_type9

    attr_accessor :caption5

    attr_accessor :data_type6

    attr_accessor :caption4

    attr_accessor :data_type7

    attr_accessor :caption3

    attr_accessor :data_type4

    attr_accessor :caption2

    attr_accessor :data_type5

    attr_accessor :caption9

    attr_accessor :data_type2

    attr_accessor :caption8

    attr_accessor :data_type3

    attr_accessor :caption7

    attr_accessor :data_type1

    attr_accessor :price

    attr_accessor :data_type14

    attr_accessor :data_type13

    attr_accessor :data_type12

    attr_accessor :data_type11

    attr_accessor :data_type10

    attr_accessor :data_type19

    attr_accessor :data_type18

    attr_accessor :data_type17

    attr_accessor :data_type16

    attr_accessor :data_type15

    attr_accessor :eproduct_message

    attr_accessor :template_expression

    attr_accessor :lead_time

    attr_accessor :user_defined_list9

    attr_accessor :user_defined_list8

    attr_accessor :user_defined_list7

    attr_accessor :data_type20

    attr_accessor :user_defined_list6

    attr_accessor :user_defined_list5

    attr_accessor :user_defined_list4

    attr_accessor :user_defined_list3

    attr_accessor :user_defined_list2

    attr_accessor :user_defined_list1

    attr_accessor :price_text

    attr_accessor :printable

    attr_accessor :production_id

    attr_accessor :expression19

    attr_accessor :expression20

    attr_accessor :max_weight_per_box

    attr_accessor :user_defined_list20

    attr_accessor :downloadable

    attr_accessor :caption20

    attr_accessor :expression10

    attr_accessor :expression8

    attr_accessor :expression9

    attr_accessor :expression12

    attr_accessor :user_defined_list18

    attr_accessor :expression11

    attr_accessor :user_defined_list17

    attr_accessor :expression14

    attr_accessor :user_defined_list16

    attr_accessor :expression13

    attr_accessor :user_defined_list15

    attr_accessor :expression16

    attr_accessor :expression15

    attr_accessor :expression18

    attr_accessor :expression17

    attr_accessor :user_defined_list19

    attr_accessor :user_defined_list10

    attr_accessor :addl_desc

    attr_accessor :user_defined_list14

    attr_accessor :user_defined_list13

    attr_accessor :user_defined_list12

    attr_accessor :user_defined_list11

    attr_accessor :expression6

    attr_accessor :expression7

    attr_accessor :expression4

    attr_accessor :expression5

    attr_accessor :expression2

    attr_accessor :expression3

    attr_accessor :expression1

    attr_accessor :caption10

    attr_accessor :show_price

    attr_accessor :caption11

    attr_accessor :caption12

    attr_accessor :caption13

    attr_accessor :caption14

    attr_accessor :caption16

    attr_accessor :caption17

    attr_accessor :caption18

    attr_accessor :caption19

    attr_accessor :customer


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'fields' => :'fields',
        :'id' => :'id',
        :'active' => :'active',
        :'version' => :'version',
        :'caption15' => :'caption15',
        :'description' => :'description',
        :'caption6' => :'caption6',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sales_category' => :'salesCategory',
        :'item_template' => :'itemTemplate',
        :'caption1' => :'caption1',
        :'data_type8' => :'dataType8',
        :'data_type9' => :'dataType9',
        :'caption5' => :'caption5',
        :'data_type6' => :'dataType6',
        :'caption4' => :'caption4',
        :'data_type7' => :'dataType7',
        :'caption3' => :'caption3',
        :'data_type4' => :'dataType4',
        :'caption2' => :'caption2',
        :'data_type5' => :'dataType5',
        :'caption9' => :'caption9',
        :'data_type2' => :'dataType2',
        :'caption8' => :'caption8',
        :'data_type3' => :'dataType3',
        :'caption7' => :'caption7',
        :'data_type1' => :'dataType1',
        :'price' => :'price',
        :'data_type14' => :'dataType14',
        :'data_type13' => :'dataType13',
        :'data_type12' => :'dataType12',
        :'data_type11' => :'dataType11',
        :'data_type10' => :'dataType10',
        :'data_type19' => :'dataType19',
        :'data_type18' => :'dataType18',
        :'data_type17' => :'dataType17',
        :'data_type16' => :'dataType16',
        :'data_type15' => :'dataType15',
        :'eproduct_message' => :'eproductMessage',
        :'template_expression' => :'templateExpression',
        :'lead_time' => :'leadTime',
        :'user_defined_list9' => :'userDefinedList9',
        :'user_defined_list8' => :'userDefinedList8',
        :'user_defined_list7' => :'userDefinedList7',
        :'data_type20' => :'dataType20',
        :'user_defined_list6' => :'userDefinedList6',
        :'user_defined_list5' => :'userDefinedList5',
        :'user_defined_list4' => :'userDefinedList4',
        :'user_defined_list3' => :'userDefinedList3',
        :'user_defined_list2' => :'userDefinedList2',
        :'user_defined_list1' => :'userDefinedList1',
        :'price_text' => :'priceText',
        :'printable' => :'printable',
        :'production_id' => :'productionID',
        :'expression19' => :'expression19',
        :'expression20' => :'expression20',
        :'max_weight_per_box' => :'maxWeightPerBox',
        :'user_defined_list20' => :'userDefinedList20',
        :'downloadable' => :'downloadable',
        :'caption20' => :'caption20',
        :'expression10' => :'expression10',
        :'expression8' => :'expression8',
        :'expression9' => :'expression9',
        :'expression12' => :'expression12',
        :'user_defined_list18' => :'userDefinedList18',
        :'expression11' => :'expression11',
        :'user_defined_list17' => :'userDefinedList17',
        :'expression14' => :'expression14',
        :'user_defined_list16' => :'userDefinedList16',
        :'expression13' => :'expression13',
        :'user_defined_list15' => :'userDefinedList15',
        :'expression16' => :'expression16',
        :'expression15' => :'expression15',
        :'expression18' => :'expression18',
        :'expression17' => :'expression17',
        :'user_defined_list19' => :'userDefinedList19',
        :'user_defined_list10' => :'userDefinedList10',
        :'addl_desc' => :'addlDesc',
        :'user_defined_list14' => :'userDefinedList14',
        :'user_defined_list13' => :'userDefinedList13',
        :'user_defined_list12' => :'userDefinedList12',
        :'user_defined_list11' => :'userDefinedList11',
        :'expression6' => :'expression6',
        :'expression7' => :'expression7',
        :'expression4' => :'expression4',
        :'expression5' => :'expression5',
        :'expression2' => :'expression2',
        :'expression3' => :'expression3',
        :'expression1' => :'expression1',
        :'caption10' => :'caption10',
        :'show_price' => :'showPrice',
        :'caption11' => :'caption11',
        :'caption12' => :'caption12',
        :'caption13' => :'caption13',
        :'caption14' => :'caption14',
        :'caption16' => :'caption16',
        :'caption17' => :'caption17',
        :'caption18' => :'caption18',
        :'caption19' => :'caption19',
        :'customer' => :'customer'
      }
    end
  end
end
