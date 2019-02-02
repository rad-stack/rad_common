module RadCompany
  extend ActiveSupport::Concern

  included do
    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    schema_validations except: :valid_user_domains

    validates_with EmailAddressValidator, fields: %i[email]
    validate :validate_only_one, on: :create
    validate :validate_domains
    validates_with PhoneNumberValidator

    audited
  end

  module ClassMethods
    def main
      Company.first
    end
  end

  def valid_user_domains_entry=(value)
    if value
      items = value.split(',')
      stripped = items.map { |item| item.strip }
      self.valid_user_domains = stripped.reject { |item| item.blank? }
    else
      self.valid_user_domains = '{}'
    end
  end

  def valid_user_domains_entry
    valid_user_domains&.join(', ')
  end

  def full_address
    "#{address_line_1}, #{address_line_2}"
  end

  def address_line_1
    line = address_1
    line = "#{line}, #{address_2}" if address_2.present?
    line
  end

  def address_line_2
    "#{city}, #{state} #{zipcode}"
  end

  def send_system_message(message)
    User.active.each do |user|
      RadbearMailer.simple_message(user, "Important Message From #{I18n.t(:app_name)}", message).deliver_later
    end
  end

  def global_validity_ran!
    update! validity_checked_at: Time.zone.now
  end

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end
