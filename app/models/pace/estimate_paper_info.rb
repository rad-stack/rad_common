module Pace
  class EstimatePaperInfo < Base
    attr_accessor :paper_price

    attr_accessor :alt_currency_paper

    attr_accessor :uom

    attr_accessor :material_type

    attr_accessor :buy_size_h

    attr_accessor :buy_size_w

    attr_accessor :paper_description

    attr_accessor :weight

    attr_accessor :inventory_item

    attr_accessor :paper_source

    attr_accessor :paper_quote_num

    attr_accessor :paper_quoted_price

    attr_accessor :vendor_paper_vendor

    attr_accessor :stock_number

    attr_accessor :vendor_paper

    attr_accessor :buy_size_grain_direction

    attr_accessor :buy_size_grain_h

    attr_accessor :buy_size_grain_w

    attr_accessor :buy_size_grain_grain


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'paper_price' => :'paperPrice',
        :'alt_currency_paper' => :'altCurrencyPaper',
        :'uom' => :'uom',
        :'material_type' => :'materialType',
        :'buy_size_h' => :'buySizeH',
        :'buy_size_w' => :'buySizeW',
        :'paper_description' => :'paperDescription',
        :'weight' => :'weight',
        :'inventory_item' => :'inventoryItem',
        :'paper_source' => :'paperSource',
        :'paper_quote_num' => :'paperQuoteNum',
        :'paper_quoted_price' => :'paperQuotedPrice',
        :'vendor_paper_vendor' => :'vendorPaperVendor',
        :'stock_number' => :'stockNumber',
        :'vendor_paper' => :'vendorPaper',
        :'buy_size_grain_direction' => :'buySizeGrainDirection',
        :'buy_size_grain_h' => :'buySizeGrainH',
        :'buy_size_grain_w' => :'buySizeGrainW',
        :'buy_size_grain_grain' => :'buySizeGrainGrain'
      }
    end
  end
end
