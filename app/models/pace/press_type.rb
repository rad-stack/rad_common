module Pace
  class PressType < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :description

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :use_total_impressions

    attr_accessor :uses_ink

    attr_accessor :uses_press_events

    attr_accessor :run_speed_side2_spoilage

    attr_accessor :split_forms

    attr_accessor :speed_factor

    attr_accessor :press_type

    attr_accessor :exclude_odd_press_form_mr_time

    attr_accessor :impose_centered_flats

    attr_accessor :separate_dry_time

    attr_accessor :use_duplex_charge_for_side2

    attr_accessor :run_speed_side1_unit_charge

    attr_accessor :duplicator

    attr_accessor :can_tile

    attr_accessor :separate_sizes

    attr_accessor :press_speed_method

    attr_accessor :color_selection

    attr_accessor :run_speed_colors

    attr_accessor :run_speed_size

    attr_accessor :run_speed_side2_unit_charge

    attr_accessor :press_event_calculation_method

    attr_accessor :allow_multiple_fixed_cutoffs

    attr_accessor :flat_size_speed

    attr_accessor :partial_units

    attr_accessor :interpolate_speed

    attr_accessor :run_speed_ink_type

    attr_accessor :no_odd_press_form

    attr_accessor :run_speed_side2_speed

    attr_accessor :uses_plates


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'description' => :'description',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'use_total_impressions' => :'useTotalImpressions',
        :'uses_ink' => :'usesInk',
        :'uses_press_events' => :'usesPressEvents',
        :'run_speed_side2_spoilage' => :'runSpeedSide2Spoilage',
        :'split_forms' => :'splitForms',
        :'speed_factor' => :'speedFactor',
        :'press_type' => :'pressType',
        :'exclude_odd_press_form_mr_time' => :'excludeOddPressFormMRTime',
        :'impose_centered_flats' => :'imposeCenteredFlats',
        :'separate_dry_time' => :'separateDryTime',
        :'use_duplex_charge_for_side2' => :'useDuplexChargeForSide2',
        :'run_speed_side1_unit_charge' => :'runSpeedSide1UnitCharge',
        :'duplicator' => :'duplicator',
        :'can_tile' => :'canTile',
        :'separate_sizes' => :'separateSizes',
        :'press_speed_method' => :'pressSpeedMethod',
        :'color_selection' => :'colorSelection',
        :'run_speed_colors' => :'runSpeedColors',
        :'run_speed_size' => :'runSpeedSize',
        :'run_speed_side2_unit_charge' => :'runSpeedSide2UnitCharge',
        :'press_event_calculation_method' => :'pressEventCalculationMethod',
        :'allow_multiple_fixed_cutoffs' => :'allowMultipleFixedCutoffs',
        :'flat_size_speed' => :'flatSizeSpeed',
        :'partial_units' => :'partialUnits',
        :'interpolate_speed' => :'interpolateSpeed',
        :'run_speed_ink_type' => :'runSpeedInkType',
        :'no_odd_press_form' => :'noOddPressForm',
        :'run_speed_side2_speed' => :'runSpeedSide2Speed',
        :'uses_plates' => :'usesPlates'
      }
    end
  end
end
