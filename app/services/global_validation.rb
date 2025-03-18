class GlobalValidation
  attr_accessor :override_model, :run_stats

  def initialize
    @run_stats = []
  end

  def run
    return unless needs_to_run?

    error_messages = check_global_validity
    payload = { error_count: error_messages.size, error_messages: error_messages.take(1000) }

    Notifications::InvalidDataWasFoundNotification.main(payload).notify! if error_messages.any?
    Notifications::GlobalValidityRanLongNotification.main(@run_stats).notify! if took_too_long?

    Company.main.global_validity_ran!
  end

  def check_global_validity
    error_messages = []

    total_error_count = 0

    models_to_check.each do |model|
      next if exclude_models.include?(model)

      start_time = Time.current
      model_errors, error_count = check_model(model)
      error_messages.concat(model_errors) if model_errors.present?
      end_time = Time.current
      add_stats model, start_time, end_time, error_count
      total_error_count += error_count
    end

    if @override_model.blank?
      specific_queries = RadConfig.global_validity_include!

      specific_queries.each do |query|
        start_time = Time.current
        query_errors, error_count = check_query_records(query)
        error_messages.concat(query_errors) if query_errors.present?
        end_time = Time.current
        add_stats query.call.to_sql, start_time, end_time, error_count
        total_error_count += error_count
      end
    end

    @run_stats.sort_by! { |item| item[:run_seconds] }
    @run_stats.reverse!

    error_messages
  end

  def self.available_models
    GlobalValidation.new.models_to_check
  end

  def models_to_check
    return [@override_model] if @override_model.present?

    RadCommon::AppInfo.new.application_models - exclude_models
  end

  private

    def needs_to_run?
      return true if @override_model.present?

      company = Company.main

      company.validity_checked_at.blank? ||
        company.validity_checked_at <= RadConfig.global_validity_days!.days.ago
    end

    def exclude_models
      return [] if @override_model.present?

      RadConfig.global_validity_exclude!
    end

    def check_model(model)
      problems = []
      error_count = 0

      klass = model.safe_constantize
      raise "unknown model #{model}" if klass.nil?

      klass.find_each do |record|
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
      record.running_global_validity = true if record.respond_to?(:running_global_validity)

      return if record.valid?

      messages = record.errors.full_messages

      supressions = RadConfig.global_validity_supress!
      supression = supressions.select { |item| item[:class] == record.class.to_s }.first

      messages -= supression[:messages] if supression
      return unless messages.any?

      error_messages_array.push([record, messages.join(', ')])
    end

    def add_stats(item_name, start_time, end_time, error_count)
      @run_stats.push(item_name: item_name,
                      start_time: start_time,
                      end_time: end_time,
                      run_seconds: (end_time - start_time).round,
                      error_count: error_count)
    end

    def took_too_long?
      @run_stats.sum { |item| item[:run_seconds] } > RadConfig.global_validity_timeout_hours!.hours
    end
end
