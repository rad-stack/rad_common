module DuplicatesHelper
  def duplicate_actions(record, model)
    return unless policy(record).destroy? && !params["#{model.to_s.downcase}_id"]

    [link_to(icon('arrow-right', 'Skip for now, review later'),
             do_later_duplicates_path(model: record.class, id: record.id),
             method: :put,
             class: 'btn btn-warning btn-sm')]
  end

  def duplicates_badge_count(model_name)
    unless RadCommon::AppInfo.new.duplicates_enabled?(model_name) &&
           policy(model_name.constantize.new).resolve_duplicates?
      return 0
    end

    model_name.constantize.high_duplicates.count
  end

  def pluralize_model_string(model_string)
    model_string.pluralize(2)
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
    return secured_link(record.send(item[:name].to_s.gsub('_id', ''))) if item[:type] == :association
    return if record.send(item[:name]).blank?

    link_to record.send(item[:name]), record
  end
end
