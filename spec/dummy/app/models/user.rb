class User < ApplicationRecord
  include RadbearUser
  include RadAuthy

  belongs_to :user_status
  has_many :security_roles_users, dependent: :destroy
  has_many :security_roles, through: :security_roles_users, dependent: :destroy

  devise :authy_authenticatable, :database_authenticatable, :registerable, :confirmable, :recoverable,
         :trackable, :timeoutable, :lockable, :password_archivable, :password_expirable,
         :secure_validatable, :expirable, :invitable

  scope :active, -> { joins(:user_status).where('user_statuses.active = TRUE') }
  scope :inactive, -> { joins(:user_status).where('user_statuses.active = FALSE') }
  scope :admins, -> { active.where('users.id IN (SELECT user_id FROM security_roles_users INNER JOIN security_roles ON security_roles_users.security_role_id = security_roles.id WHERE security_roles.admin = TRUE)') }
  scope :pending, -> { where(user_status_id: UserStatus.default_pending_status.id) }
  scope :by_name, -> { order(:first_name, :last_name) }
  scope :with_mobile_phone, -> { where.not(mobile_phone: ['', nil]) }
  scope :without_mobile_phone, -> { where(mobile_phone: ['', nil]) }
  scope :recent_first, -> { order('users.created_at DESC') }

  validates_with PhoneNumberValidator, fields: [:mobile_phone]
  validates_with TwilioPhoneValidator, fields: [{ field: :mobile_phone, type: :mobile }]

  before_validation :check_defaults
  after_invitation_accepted :notify_user_accepted

  audited except: %i[password password_confirmation encrypted_password reset_password_token confirmation_token authentication_token unlock_token]

  def to_s
    "#{first_name} #{last_name}"
  end

  def active_for_authentication?
    super && user_status && user_status.active
  end

  def active
    active_for_authentication?
  end

  def inactive_message
    if !user_status.active
      :not_approved
    else
      super
    end
  end

  def send_devise_notification(notification, *args)
    # background devise emails
    # https://github.com/plataformatec/devise#activejob-integration

    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_reset_password_instructions
    if invited_to_sign_up?
      errors.add :email, :not_found
    else
      super
    end
  end

  private

    def check_defaults
      status = auto_approve? ? UserStatus.default_active_status : UserStatus.default_pending_status
      self.user_status = status if new_record? && !user_status
    end
end
