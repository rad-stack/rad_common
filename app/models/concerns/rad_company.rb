module RadCompany
  extend ActiveSupport::Concern

  included do
    alias_attribute :to_s, :name

    scope :by_id, -> { order(:id) }

    schema_validations except: :valid_user_domains

    validates :email, format: { with: Devise.email_regexp, message: 'has an invalid email format' }
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

  def check_global_validity
    error_messages = []

    exclude_models = [ActiveRecord::SchemaMigration,
                      ApplicationRecord,
                      Audited::Audit,
                      SecurityRolesUser] + Rails.application.config.global_validity_exclude

    Rails.application.eager_load!
    all_models = ActiveRecord::Base.descendants
    models = all_models - exclude_models

    models.each do |model|
      error_messages = error_messages.concat(check_model(model)) unless exclude_models.include?(model.to_s)
    end

    specific_queries = Rails.application.config.global_validity_include

    specific_queries.each { |query| error_messages = error_messages.concat(check_query_records(query)) }

    error_messages
  end

  private

    def check_model(model)
      puts "global validity check: starting #{model}: #{Time.zone.now}"

      problems = []
      model.find_each { |record| validate_record(record, problems) }

      puts "global validity check: ending #{model}: #{Time.zone.now}"

      problems
    end

    def check_query_records(query)
      puts "global validity check: starting #{query}: #{Time.zone.now}"

      problems = []
      records = query.call
      records.find_each { |record| validate_record(record, problems) }

      puts "global validity check: ending #{query}: #{Time.zone.now}"

      problems
    end

    def validate_record(record, error_messages_array)
      record.bypass_geocoding = true if record.respond_to?(:bypass_geocoding)

      return if record.valid?

      messages = record.errors.full_messages

      supressions = Rails.application.config.global_validity_supress || []
      supression = supressions.select { |item| item[:class] == record.class.to_s }.first

      messages -= supression[:messages] if supression
      return unless messages.any?

      error_messages_array.push([record, messages.join(', ')])
    end

    def validate_only_one
      errors.add(:base, 'Only one company record is allowed.') if Company.count.positive?
    end

    def validate_domains
      errors.add(:valid_user_domains, 'needs at least one domain') if valid_user_domains.count.zero?
    end
end
