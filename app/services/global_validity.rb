class GlobalValidity
  attr_accessor :override_model

  def run
    return unless needs_to_run?

    error_messages = check_global_validity
    Notifications::GlobalValidityNotification.new.notify!(error_messages) if error_messages.any?
    Company.main.global_validity_ran!
  end

  def check_global_validity
    error_messages = []

    models_to_check.each do |model|
      start_time = Time.zone.now
      error_messages = error_messages.concat(check_model(model)) unless exclude_models.include?(model.to_s)
      end_time = Time.zone.now
      log_time(start_time, end_time, model)
    end

    specific_queries = Rails.application.config.global_validity_include

    specific_queries.each { |query| error_messages = error_messages.concat(check_query_records(query)) }

    error_messages
  end

  def log_time(start_time, end_time, model)
    Rails.logger.debug "#{model} took #{Time.at((end_time - start_time)).utc.strftime('%H:%M:%S')} to validate."
  end

  private

    def needs_to_run?
      return true if @override_model.present?

      company = Company.main

      company.validity_checked_at.blank? ||
        company.validity_checked_at <= Rails.application.config.global_validity_days.days.ago
    end

    def models_to_check
      return [@override_model.constantize] if @override_model.present?

      Rails.application.eager_load!
      all_models = ActiveRecord::Base.descendants
      all_models - exclude_models
    end

    def exclude_models
      return [] if @override_model.present?

      [ActiveRecord::SchemaMigration,
       ApplicationRecord,
       Audited::Audit] + Rails.application.config.global_validity_exclude
    end

    def check_model(model)
      problems = []
      model.find_each { |record| validate_record(record, problems) }
      problems
    end

    def check_query_records(query)
      problems = []
      records = query.call
      records.find_each { |record| validate_record(record, problems) }
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
end
