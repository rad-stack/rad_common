module RadSearch
  class BooleanFilter < SearchFilter
    BOOLEAN_OPTIONS = [['Yes', true], ['No', false]].freeze

    def initialize(column:, input_label: nil, name: nil, **)
      input_label ||= (name || column).to_s.titleize
      super(column: column, input_label: input_label, name: name, options: BOOLEAN_OPTIONS, **)
    end

    def blank_value_label
      'All'
    end
  end
end
