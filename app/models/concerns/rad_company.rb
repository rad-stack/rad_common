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
    validates :twilio_phone_numbers, presence: true

    audited
  end

  module ClassMethods
    def main
      Company.first
    end

    def staging?
      ENV['STAGING'] == 'true'
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

  def next_phone_number
    if Rails.env.development?
      ENV['TWILIO_TEST_FROM_PHONE_NUMBER']
    else
      num_of_nums = twilio_phone_numbers.length

      if num_of_nums.zero?
        return nil
      elsif num_of_nums == 1
        return twilio_phone_numbers[0]
      else
        next_number = twilio_phone_numbers[current_phone]

        if current_phone < (num_of_nums - 1)
          update(current_phone: (current_phone + 1))
        else
          update(current_phone: 0)
        end

        next_number
      end
    end
  end

  def sanitize_twilio_numbers
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
