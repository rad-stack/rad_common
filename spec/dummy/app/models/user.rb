class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable, :lockable, :invitable,
         :timeoutable, :password_archivable, :password_expirable, :secure_validatable, :expirable,
         :authy_authenticatable

  include RadbearUser
  include RadAuthy

  # TODO: try moving these to the concern
  has_many :user_customers, dependent: :destroy
  has_many :customers, through: :user_customers

  has_many :divisions, foreign_key: 'owner_id', dependent: :restrict_with_error

  audited except: USER_AUDIT_COLUMNS_DISABLED
end
