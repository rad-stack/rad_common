class GlobalValidity
  attr_accessor :override_model

  def run
    return unless needs_to_run?

    error_messages = check_global_validity
    Notifications::InvalidDataWasFoundNotification.main.notify!(error_messages) if error_messages.any?
    Company.main.global_validity_ran!
  end

  def check_global_validity
    error_messages = []

    total_start_time = Time.current
    total_error_count = 0
    models_to_check.each do |model|
      next if exclude_models.include?(model)

      Rails.logger.info("GlobalValidity stats: #{model} starting")
      start_time = Time.current
      model_errors, error_count = check_model(model)
      error_messages = error_messages.concat(model_errors) if model_errors.present?
      end_time = Time.current
      Rails.logger.info(log_time_text(start_time, end_time, model))
      Rails.logger.info(log_error_count_text(model, error_count)) unless error_count.zero?
      total_error_count += error_count
    end

    specific_queries = RadCommon.global_validity_include

    specific_queries.each do |query|
      Rails.logger.info("GlobalValidity stats: #{query.call.to_sql} starting")
      start_time = Time.current
      query_errors, error_count = check_query_records(query)
      error_messages = error_messages.concat(query_errors) if query_errors.present?
      end_time = Time.current
      Rails.logger.info(log_time_text(start_time, end_time, query.call.to_sql))
      Rails.logger.info(log_error_count_text(query.call.to_sql, error_count)) unless error_count.zero?
      total_error_count += error_count
    end

    total_end_time = Time.current
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
        company.validity_checked_at <= RadCommon.global_validity_days.days.ago
    end

    def models_to_check
      return [@override_model.constantize] if @override_model.present?

      RadCommon::AppInfo.new.application_models - exclude_models
    end

    def exclude_models
      return [] if @override_model.present?

      RadCommon.global_validity_exclude
    end

    def check_model(model)
      problems = []
      error_count = 0

      model.safe_constantize.find_each do |record|
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

      supressions = RadCommon.global_validity_supress || []
      supression = supressions.select { |item| item[:class] == record.class.to_s }.first

      messages -= supression[:messages] if supression
      return unless messages.any?

      error_messages_array.push([record, messages.join(', ')])
    end
end
