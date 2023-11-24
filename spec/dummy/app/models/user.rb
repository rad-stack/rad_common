class User < ApplicationRecord
  include RadDeviseHigh
  include RadUser
  include DuplicateFixable

  has_many :divisions, foreign_key: 'owner_id', dependent: :restrict_with_error

  validates :birth_date, presence: true, if: :require_profile?
  validates :birth_date, absence: true, unless: :allow_profile?

  audited except: USER_AUDIT_COLUMNS_DISABLED

  def allow_profile?
    !admin?
  end

  def require_profile?
    !admin? && profile_entered?
  end
end
