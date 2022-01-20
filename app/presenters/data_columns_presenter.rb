class DataColumnsPresenter
  attr_reader :local_assigns, :all_data, :columns

  def initialize(view_context, local_assigns = nil)
    @view_context = view_context
    @local_assigns = local_assigns

    @all_data = []

    data&.each do |item|
      case item
      when Hash
        if item[:value].present?
          @all_data.push(item)
        end
      when Symbol
        value = resource.send(item)

        if value.present? || value.class.to_s == 'FalseClass'
          @all_data.push(item)
        end
      else
        raise "invalid data type: #{item.class}"
      end
    end

    if @all_data.count.zero?
      @columns = [stats]
    elsif @all_data.count <= 5
      @columns = [@all_data, stats]
    elsif force_single_column
      @columns = [@all_data + stats]
    else
      @all_data += stats
      @columns = @all_data.each_slice((@all_data.count / 2.to_f).ceil).to_a
    end
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
      if item[:label]
        item[:label]
      else
        item[:value]
      end
    when Symbol
      translation = I18n.t "activerecord.attributes.#{resource.class.to_s.underscore}.#{item}"

      if translation.include?('translation missing')
        item.to_s.titlecase
      else
        translation
      end
    end
  end

  def item_value(item)
    case item
    when Hash
      if item[:label]
        item[:value]
      else
        nil
      end
    when Symbol
      value = resource.send(item)

      if resource.defined_enums.has_key?(item.to_s)
        return RadicalEnum.new(resource.class, item.to_s).translated_option(resource)
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
end
