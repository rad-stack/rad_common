class UserCustomer < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  scope :by_name, -> { joins(:customer).order('customers.name') }

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

  private

    def validate_user
      return if user.blank?

      errors.add(:user, 'is not valid when internal') if user.internal?
    end

    def validate_email_domain
      return if user.blank? || customer.blank? || !user.user_status.validate_email

      components = user.email.split('@')
      raise "invalid email: #{user.email}" unless components.count == 2

      domains = customer.valid_user_domains
      return if domains.include?(components[1])

      errors.add(:customer, "is not valid for this email user's address, please contact the system administrator")
    end
end
