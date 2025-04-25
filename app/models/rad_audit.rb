class RadAudit < Audited::Audit
  scope :system_generated, -> { where(user_id: nil) }

  scope :missing_auditable_models, lambda {
    where.not(auditable_type: RadCommon::AppInfo.new.audited_models)
         .group(:auditable_type)
         .select(:auditable_type)
         .pluck(:auditable_type)
  }

  scope :missing_associated_models, lambda {
    where.not(associated_type: RadCommon::AppInfo.new.audited_models)
         .group(:associated_type)
         .select(:associated_type)
         .pluck(:associated_type)
  }

  def self.missing_audited_models
    (RadAudit.missing_auditable_models + RadAudit.missing_associated_models).uniq.sort
  end
end
