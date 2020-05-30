class RadAudit < Audited::Audit
  scope :system_generated, -> { where(user_id: nil) }
end
