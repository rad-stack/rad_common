class GlobalValidity
  attr_accessor :override_model

  def run
    return unless needs_to_run?

    error_messages = check_global_validity
    Notifications::GlobalValidityNotification.notify!(error_messages) if error_messages.any?
    Company.main.global_validity_ran!
  end

  def check_global_validity
    error_messages = []

    total_start_time = Time.zone.now
    total_error_count = 0
    models_to_check.each do |model|
      Rails.logger.info("GlobalValidity stats: #{model} starting")
      start_time = Time.zone.now
      model_errors, error_count = check_model(model) unless exclude_models.include?(model.to_s)
      error_messages = error_messages.concat(model_errors) if model_errors.present?
      end_time = Time.zone.now
      Rails.logger.info(log_time_text(start_time, end_time, model))
      Rails.logger.info(log_error_count_text(model, error_count)) unless error_count.zero?
      total_error_count += error_count
    end

    specific_queries = Rails.application.config.global_validity_include

    specific_queries.each do |query|
      Rails.logger.info("GlobalValidity stats: #{query.call.to_sql} starting")
      start_time = Time.zone.now
      query_errors, error_count = check_query_records(query)
      error_messages = error_messages.concat(query_errors) if query_errors.present?
      end_time = Time.zone.now
      Rails.logger.info(log_time_text(start_time, end_time, query.call.to_sql))
      Rails.logger.info(log_error_count_text(model, error_count)) unless error_count.zero?
      total_error_count += error_count
    end

    total_end_time = Time.zone.now
    Rails.logger.info(log_time_text(total_start_time, total_end_time, 'All Models'))
    Rails.logger.info(log_error_count_text('All Models', total_error_count)) unless total_error_count.zero?

    error_messages
  end

  def log_time_text(start_time, end_time, model)
    "GlobalValidity stats: #{model} took #{Time.at((end_time - start_time)).utc.strftime('%H:%M:%S')} to validate."
  end

  def log_error_count_text(model, count)
    "GlobalValidity stats: #{model} has #{ApplicationController.helpers.pluralize(count, 'invalid record')}."
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
      error_count = 0
      model.find_each do |record|
        error_count += 1 if validate_record(record, problems)
      end
      [problems, error_count]
    end

    def check_query_records(query)
      problems = []
      error_count = 0
      records = query.call
      records.find_each do |record|
        error_count += 1 if validate_record(record, problems)
      end
      [problems, error_count]
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
