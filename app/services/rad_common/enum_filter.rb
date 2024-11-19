module RadCommon
  class EnumFilter < SearchFilter
    def initialize(column:, klass:, input_label: nil, name: nil, enum: nil, **)
      input_label ||= (name || column).to_s.titleize
      options ||= RadEnum.new(klass, column.to_s.pluralize || enum).db_options
      super(column: column, input_label: input_label, name: name, options: options, **)
    end
  end
end
