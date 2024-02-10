module RadTable
  class AuditModelLinkColumn < Column
    def render(record)
      if record.action == 'destroy'
        "#{record.auditable_type} (#{record.auditable_id})"
      else
        view_context.audit_model_link(record, record.auditable)
      end
    end
  end
end
