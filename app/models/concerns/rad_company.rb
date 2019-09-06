module RadCompany
  extend ActiveSupport::Concern

  included do
    include HasAddress

    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    schema_validations except: %i[twilio_phone_numbers valid_user_domains]

    before_validation :sanitize_twilio_numbers

    validates_with EmailAddressValidator, fields: %i[email]
    validates_with PhoneNumberValidator
    validate :validate_only_one, on: :create
    validate :validate_domains
    validates :twilio_phone_numbers, presence: true, if: -> { RadicalTwilio.twilio_enabled? && Company.has_attribute?(:twilio_phone_numbers) }

    audited
  end

  module ClassMethods
    def main
      Company.first
    end

    def staging?
      ENV['STAGING'] == 'true'
    end

    def review_app?
      ENV['REVIEW_APP'].present? && ENV['REVIEW_APP'] == 'true'
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

  def global_validity_ran!
    update! validity_checked_at: Time.zone.now
  end

  def usage_stats
    today = Time.zone.now

    usage_headers = (0..5).to_a.reverse.map do |item|
      { start: today.advance(months: -item).beginning_of_month.beginning_of_day,
        end: today.advance(months: -item).end_of_month.end_of_day,
        label: today.advance(months: -item).beginning_of_month.strftime('%B, %Y') }
    end

    usage_items = Rails.application.config.system_usage_models.sort
    usage_data = []

    usage_items.each do |item|
      data = []

      usage_headers.each do |header|
        result = item.constantize.unscoped.where(created_at: header[:start]..header[:end]).count
        data.push(result)
      end

      usage_data.push(data)
    end

    [usage_headers, usage_items, usage_data]
  end

  def sanitize_twilio_numbers
    return unless RadicalTwilio.twilio_enabled? && Company.has_attribute?(:twilio_phone_numbers)

    self.twilio_phone_numbers = twilio_phone_numbers.reject(&:blank?) if twilio_phone_numbers_changed? && twilio_phone_numbers.any?
  end

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end
