class RadAudit < Audited::Audit
  scope :system_generated, -> { where(user_id: nil) }

  scope :missing_models, lambda {
    where.not(auditable_type: RadCommon::AppInfo.new.audited_models)
         .group(:auditable_type)
         .select(:auditable_type)
         .pluck(:auditable_type)
  }
end
