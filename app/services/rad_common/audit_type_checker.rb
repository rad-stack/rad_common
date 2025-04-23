module RadCommon
  class AuditTypeChecker
    def check
      valid_types = RadCommon::AppInfo.new.audited_models.map(&:to_s) + ['ActiveStorage::Attachment']

      RadAudit.where.not(auditable_type: valid_types)
              .group(:auditable_type)
              .select(:auditable_type)
              .pluck(:auditable_type)
              .sort
    end
  end
end
