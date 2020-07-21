class User < ApplicationRecord
  devise :authy_authenticatable, :database_authenticatable, :registerable, :confirmable, :recoverable, :trackable,
         :timeoutable, :lockable, :password_archivable, :password_expirable, :secure_validatable, :expirable, :invitable

  include RadbearUser
  include RadAuthy
  include FirebaseSync

  audited except: USER_AUDIT_COLUMNS_DISABLED
end
