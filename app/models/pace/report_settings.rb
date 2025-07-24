module Pace
  class ReportSettings < Base
    attr_accessor :id

    attr_accessor :language

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :default_font

    attr_accessor :language_region

    attr_accessor :letter_to_a4_policy

    attr_accessor :report_paper


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'language' => :'language',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'default_font' => :'defaultFont',
        :'language_region' => :'languageRegion',
        :'letter_to_a4_policy' => :'letterToA4Policy',
        :'report_paper' => :'reportPaper'
      }
    end
  end
end
