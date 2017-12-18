class User < ApplicationRecord
  include Authority::UserAbilities
  include Authority::Abilities
  include RadbearUser

  belongs_to :security_group
  belongs_to :user_status

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  scope :active, -> { joins(:user_status).where('user_statuses.active = TRUE') }
  scope :admins, -> { active.where(admin: true) }
  scope :pending, -> { where(user_status_id: UserStatus.default_pending_status.id) }
  scope :by_name, -> { order(:first_name, :last_name) }
  scope :super_admins, -> { active.where(admin: true) }
  scope :recent_first, -> { order('users.created_at DESC') }

  has_attached_file :avatar, styles: { small: '25x25#', medium: '50x50#', normal: '100x100#', large: '200x200#' }

  validates :first_name, :last_name, presence: true
  validates_attachment_content_type :avatar, content_type: %w[image/jpg image/jpeg image/png]
  validates_with PhoneNumberValidator, fields: [:mobile_phone]

  before_validation :check_defaults

  audited except: %i[password password_confirmation encrypted_password reset_password_token confirmation_token authentication_token unlock_token]

  def to_s
    "#{first_name} #{last_name}"
  end

  private

    def check_defaults
      self.security_group = SecurityGroup.default_user unless security_group
      status = auto_approve? ? UserStatus.default_active_status : UserStatus.default_pending_status
      self.user_status = status if new_record? && !user_status
    end

end
