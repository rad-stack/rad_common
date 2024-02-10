class AuditTable < RadTable::Table
  def columns
    [
      RadTable::DatetimeColumn.new(:created_at, header: 'Date', show_distance: true),
      RadTable::AuditModelLinkColumn.new(:record_type, hidden: search.nil?),
      RadTable::Column.new(:record_id, hidden: search.nil?, value_path: :auditable_id),
      RadTable::SecuredLinkColumn.new(:user),
      RadTable::Column.new(:action, helper: :display_audited_action),
      RadTable::Column.new(:remote_address),
      RadTable::Column.new(:id, header: 'Audit ID'),
      RadTable::Column.new(:changes, helper: %i[display_audited_changes simple_format])
    ]
  end

  def path(search_params = nil)
    path = '/rad_common/audits'
    return "#{path}?search=#{search_params}" if search_params.present?

    path
  end

  def rad_common_engine?
    true
  end
end
