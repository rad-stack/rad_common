module RadCommon
  ##
  # This is used to generate a textarea form input used for a SQL WHERE IN filter for phone numbers
  # Accepted value should be a string containing multiple phone numbers
  # phone numbers can be any typical format, such as "(888) 888-8888", "888-888-8888", "8888888888"
  # delimiters can be: semi-colon, comma, or carriage return
  class PhoneNumbersFilter
    attr_reader :column, :input_label, :col_class

    ##
    # @param [String] column the database column that is being filtered
    def initialize(column:, input_label: nil, col_class: nil)
      @column = column&.downcase
      @input_label = input_label
      @col_class = col_class
    end

    def filter_view
      'textarea'
    end

    def searchable_name
      phone_numbers_input
    end

    def phone_numbers_input
      "#{column}_text"
    end

    def apply_filter(results, params)
      value = phone_numbers_array(params)
      return results if value.blank?

      results.where(column => value)
    end

    def allow_not
      false
    end

    private

      def phone_numbers_array(params)
        array = params[phone_numbers_input]
        return if array.blank?

        array.gsub(/\-|\(|\)\ /, '').gsub(/\r|\n|\;/, ',').split(',').compact_blank.map do |phone_number|
          PhoneNumberFormatter.format(phone_number)
        end.compact_blank
      end
  end
end
