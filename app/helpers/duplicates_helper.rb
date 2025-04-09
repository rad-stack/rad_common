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

  def fix_duplicates_action(record)
    return unless record.duplicate.present? && record.duplicate.score.present? && policy(record).show?

    link_to(icon(:cubes, 'Fix Duplicates'),
            "/duplicates?model=#{record.class}&id=#{record.id}",
            class: 'btn btn-info btn-sm')
  end

  def show_reset_duplicates_link?
    return false if current_user.external?

    record = current_instance_variable
    record.present? && RadCommon::AppInfo.new.duplicates_enabled?(record.class.name) && policy(record).reset_duplicates?
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

  def not_duplicate_path(record, master_record)
    "/duplicates/not?model=#{record.class}&id=#{record.id}&master_record=#{master_record.id}"
  end

  def index_duplicates_path_record(record)
    "/duplicates?model=#{record.class}&id=#{record.id}"
  end

  def index_duplicates_path(model)
    "/duplicates?model=#{model}"
  end

  def merge_duplicates_path(record)
    "/duplicates/merge?model=#{record.class}&id=#{record.id}"
  end

  def reset_duplicates_path(record)
    "/duplicates/reset?model=#{record.class}&id=#{record.id}"
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

    record.send item[:name]
  end
end
