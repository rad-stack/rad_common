class UserCustomer < ApplicationRecord
  belongs_to :user

  SKIP_SCHEMA_VALIDATION_COLUMNS = [:customer_id].freeze

  scope :by_name, lambda {
    table_name = RadCommon::AppInfo.new.customer_table_name
    joins("INNER JOIN #{table_name} ON user_customers.customer_id = #{table_name}.id").order("#{table_name}.name")
  }

  validates :customer_id, presence: true
  validate :validate_user
  validate :validate_email_domain

  after_create :touch_user
  after_destroy :touch_user

  audited associated_with: :user

  def to_s
    "#{customer} - #{user}"
  end

  def touch_user
    user.touch
  end

  def customer
    return if customer_id.blank?

    RadCommon::AppInfo.new.customer_model_class.find(customer_id)
  end

  def customer=(customer_record)
    self.customer_id = customer_record.present? ? customer_record.id : nil
  end

  private

    def validate_user
      return if user.blank?

      errors.add(:user, 'is not valid when internal') if user.internal?
    end

    def validate_email_domain
      return unless RadicalConfig.validate_external_email_domain?
      return if user.blank? || customer.blank? || !user.user_status.validate_email

      components = user.email.split('@')
      raise "invalid email: #{user.email}" unless components.count == 2

      domains = customer.valid_user_domains
      return if domains.include?(components[1])

      errors.add(:customer, "is not valid for this email user's address, please contact the system administrator")
    end
end
