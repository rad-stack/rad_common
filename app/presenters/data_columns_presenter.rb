class DataColumnsPresenter
  attr_reader :local_assigns, :columns

  def initialize(view_context, local_assigns = nil)
    @view_context = view_context
    @local_assigns = local_assigns
    @columns = calc_columns
  end

  def _h
    @view_context
  end

  def resource
    local_assigns[:resource]
  end

  def force_single_column
    local_assigns[:force_single_column]
  end

  def no_timestamps
    local_assigns[:no_timestamps]
  end

  def data
    local_assigns[:data]
  end

  def stats
    items = []

    if !local_assigns[:resource].nil? && !no_timestamps
      if resource.respond_to?(:created_at)
        items.push(label: 'Created', value: @view_context.format_datetime(resource.created_at))
      end

      if resource.respond_to?(:updated_at) && resource.updated_at != resource.created_at
        items.push(label: 'Updated', value: @view_context.format_datetime(resource.updated_at))
      end
    end

    items
  end

  def column_class
    force_single_column ? 'col-lg-12' : 'col-lg-6'
  end

  def item_label(item)
    case item
    when Hash
      item[:label].presence || item[:value]
    when Symbol
      @view_context.translated_attribute_label(resource, item)
    end
  end

  def item_value(item)
    case item
    when Hash
      hash_item_value(item)
    when Symbol
      symbol_item_value(item)
    end
  end

  private

    def calc_columns
      items = add_data_items

      if items.count.zero?
        [stats]
      elsif items.count <= 5
        [items, stats]
      elsif force_single_column
        [items + stats]
      else
        items += stats
        items.each_slice((items.count / 2.to_f).ceil).to_a
      end
    end

    def add_data_items
      items = []

      data&.each do |item|
        case item
        when Hash
          items.push(item) if item[:value].present?
        when Symbol
          value = resource.send(item)
          items.push(item) if value.present? || value.class.to_s == 'FalseClass'
        else
          raise "invalid data type: #{item.class}"
        end
      end

      items
    end

    def hash_item_value(item)
      item[:value] if item[:label].present?
    end

    def symbol_item_value(item)
      value = resource.send(item)

      if resource.defined_enums.has_key?(item.to_s)
        return RadEnum.new(resource.class, item.to_s).translated_option(resource)
      end

      case value.class.to_s
      when 'ActiveSupport::TimeWithZone'
        @view_context.format_datetime(value)
      when 'Date'
        @view_context.format_date(value)
      when 'Time'
        @view_context.format_time(value)
      when 'TrueClass', 'FalseClass'
        @view_context.format_boolean(value)
      when 'Array'
        value.join(', ')
      else
        value
      end
    end
end
