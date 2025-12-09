class RadAudit < Audited::Audit
  scope :system_generated, -> { where(user_id: nil) }

  scope :missing_auditable_models, lambda {
    where.not(auditable_type: AppInfo.new.audited_models)
         .group(:auditable_type)
         .select(:auditable_type)
         .pluck(:auditable_type)
  }

  scope :missing_associated_models, lambda {
    where.not(associated_type: AppInfo.new.associated_audited_models)
         .group(:associated_type)
         .select(:associated_type)
         .pluck(:associated_type)
  }

  scope :sorted, -> { order(created_at: :desc) }

  def self.missing_audited_models
    (RadAudit.missing_auditable_models + RadAudit.missing_associated_models).uniq.sort
  end

  def self.for_record(record)
    RadAudit.where(auditable: record).or(RadAudit.where(associated: record))
  end
end
