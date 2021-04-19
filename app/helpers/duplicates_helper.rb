module DuplicatesHelper
  def duplicate_actions(record, model)
    return unless policy(record).destroy? && !params["#{model.to_s.downcase}_id"]

    [link_to('Skip for now, review later',
             duplicate_do_later_path(record),
             method: :put,
             class: 'btn btn-warning btn-sm')]
  end

  def plural_model_name(model)
    model.class.to_s.pluralize(2)
  end

  def pluralize_model_string(model_string)
    model_string.pluralize(2)
  end

  def not_duplicate_path(record, master_record)
    "/#{plural_model_name(record).downcase}/#{record.id}/not_duplicate?master_record=#{master_record.id}"
  end

  def show_current_duplicates_path(record)
    "/#{plural_model_name(record).downcase}/show_current_duplicates?#{record.class.to_s.downcase}_id=#{record.id}"
  end

  def merge_duplicates_path(record)
    "/#{plural_model_name(record).downcase}/#{record.id}/merge_duplicates"
  end

  def duplicate_do_later_path(record)
    "/#{plural_model_name(record).downcase}/#{record.id}/duplicate_do_later"
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

    record.attributes[item[:name].to_s]
  end
end
