module DuplicatesHelper
  def duplicate_actions(record, model)
    return unless policy(record).destroy? && !params["#{model.to_s.downcase}_id"]

    [link_to(icon('arrow-right', 'Skip for now, review later'),
             do_later_duplicates_path(model: record.class, id: record.id),
             method: :put,
             class: 'btn btn-warning btn-sm')]
  end

  def show_reset_duplicates_link?
    return false if current_user.external?

    record = current_instance_variable

    record.present? && record.respond_to?(:persisted?) && record.persisted? &&
      RadCommon::AppInfo.new.duplicates_enabled?(record.class.name) && policy(record).reset_duplicates?
  end

  def duplicates_badge(klass)
    return unless RadCommon::AppInfo.new.duplicates_enabled?(klass.name) && policy(klass.new).index_duplicates?

    count = klass.high_duplicates.count
    return unless count.positive?

    tag.span(class: 'badge alert-warning') do
      count.to_s
    end
  end

  def pluralize_model_string(model_string)
    model_string.pluralize(2)
  end

  def duplicate_item_class(global_record, current_record, item)
    global_field_value = global_record.send(item[:name])
    if item[:fields_to_match].present?
      global_field_values = item[:fields_to_match].map { |f| global_record.send(f) }.compact
      current_field_values = item[:fields_to_match].map { |f| current_record.send(f) }.compact
      return '' if global_field_values.empty?

      return global_field_values.intersect?(current_field_values) ? 'table-success' : 'table-danger'
    end

    duplicate_class(global_field_value, current_record.send(item[:name]))
  end

  def duplicate_class(global_field_value, current_field_value)
    if global_field_value.class.to_s == 'String' && current_field_value.class.to_s == 'String'
      global_field_value = global_field_value.downcase
      current_field_value = current_field_value.downcase
    end

    global_field_value = '' if global_field_value.nil?
    current_field_value = '' if current_field_value.nil?

    if global_field_value == current_field_value
      if global_field_value.blank?
        ''
      else
        'table-success'
      end
    else
      'table-danger'
    end
  end

  def show_duplicate_item(item, record)
    return item[:fields_to_match].map { |f| record.send(f) }.compact.join(', ') if item[:fields_to_match].present?
    return secured_link(record.send(item[:name].to_s.gsub('_id', ''))) if item[:type] == :association

    record.send item[:name]
  end
end
