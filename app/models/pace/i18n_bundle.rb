module Pace
  class I18nBundle < Base
    attr_accessor :name

    attr_accessor :id

    attr_accessor :language

    attr_accessor :variant

    attr_accessor :country

    attr_accessor :tags

    attr_accessor :xml

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :category

    attr_accessor :number_of_i18n_catalogue_messages

    attr_accessor :number_of_i18n_catalogue_messages_not_reviewed

    attr_accessor :all_i18n_catalogue_messages_reviewed


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'name' => :'name',
        :'id' => :'id',
        :'language' => :'language',
        :'variant' => :'variant',
        :'country' => :'country',
        :'tags' => :'tags',
        :'xml' => :'xml',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'category' => :'category',
        :'number_of_i18n_catalogue_messages' => :'numberOfI18nCatalogueMessages',
        :'number_of_i18n_catalogue_messages_not_reviewed' => :'numberOfI18nCatalogueMessagesNotReviewed',
        :'all_i18n_catalogue_messages_reviewed' => :'allI18nCatalogueMessagesReviewed'
      }
    end
  end
end
