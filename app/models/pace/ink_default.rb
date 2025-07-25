module Pace
  class InkDefault < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :colors_side1

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :ink_coverage_back

    attr_accessor :colors_total

    attr_accessor :ink_type

    attr_accessor :colors_side2

    attr_accessor :coating

    attr_accessor :varnish

    attr_accessor :coating_sides

    attr_accessor :ink_coverage_front_specify

    attr_accessor :ink_coverage_front

    attr_accessor :varnish_dry

    attr_accessor :press_ink_type

    attr_accessor :coating_dry

    attr_accessor :varnish_sides

    attr_accessor :ink_coverage_back_specify

    attr_accessor :ink_default_ink

    attr_accessor :use_advanced_ink_configuration


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'colors_side1' => :'colorsSide1',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'ink_coverage_back' => :'inkCoverageBack',
        :'colors_total' => :'colorsTotal',
        :'ink_type' => :'inkType',
        :'colors_side2' => :'colorsSide2',
        :'coating' => :'coating',
        :'varnish' => :'varnish',
        :'coating_sides' => :'coatingSides',
        :'ink_coverage_front_specify' => :'inkCoverageFrontSpecify',
        :'ink_coverage_front' => :'inkCoverageFront',
        :'varnish_dry' => :'varnishDry',
        :'press_ink_type' => :'pressInkType',
        :'coating_dry' => :'coatingDry',
        :'varnish_sides' => :'varnishSides',
        :'ink_coverage_back_specify' => :'inkCoverageBackSpecify',
        :'ink_default_ink' => :'inkDefaultInk',
        :'use_advanced_ink_configuration' => :'useAdvancedInkConfiguration'
      }
    end
  end
end
