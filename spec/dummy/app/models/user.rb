class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable,
         :timeoutable, :password_archivable, :password_expirable, :secure_validatable, :expirable,
         :twilio_verify_authenticatable

  include RadbearUser

  has_many :divisions, foreign_key: 'owner_id', dependent: :restrict_with_error

  audited except: USER_AUDIT_COLUMNS_DISABLED
end
