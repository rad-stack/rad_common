module RadCompany
  extend ActiveSupport::Concern

  included do
    include HasAddress

    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    SKIP_SCHEMA_VALIDATION_COLUMNS = [:valid_user_domains].freeze

    validates_with EmailAddressValidator, fields: %i[email]
    validates_with PhoneNumberValidator
    validate :validate_only_one, on: :create
    validate :validate_domains

    audited
  end

  module ClassMethods
    def main
      Company.first
    end

    def staging?
      ENV.fetch('STAGING') == 'true'
    end
  end

  def valid_user_domains_entry=(value)
    if value
      items = value.split(',')
      stripped = items.map(&:strip)
      self.valid_user_domains = stripped.reject(&:blank?)
    else
      self.valid_user_domains = '{}'
    end
  end

  def valid_user_domains_entry
    valid_user_domains&.join(', ')
  end

  def global_validity_ran!
    update! validity_checked_at: Time.current
  end

  def usage_stats(mode)
    today = Time.current

    usage_headers = (0..5).to_a.reverse.map do |item|
      case mode
      when 'monthly'
        { start: today.advance(months: -item).beginning_of_month.beginning_of_day,
          end: today.advance(months: -item).end_of_month.end_of_day,
          label: today.advance(months: -item).beginning_of_month.strftime('%B, %Y') }
      when 'weekly'
        { start: today.advance(weeks: -item).beginning_of_week.beginning_of_day,
          end: today.advance(weeks: -item).end_of_week.end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(weeks: -item).beginning_of_week) }
      when 'daily'
        { start: today.advance(days: -item).beginning_of_day,
          end: today.advance(days: -item).end_of_day,
          label: ApplicationController.helpers.format_date(today.advance(days: -item).beginning_of_day) }
      else
        raise 'invalid mode'
      end
    end

    usage_items = RadCommon.system_usage_models.sort
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

  private

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end
