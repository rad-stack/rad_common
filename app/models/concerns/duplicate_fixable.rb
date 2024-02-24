module DuplicateFixable
  extend ActiveSupport::Concern

  included do
    include CreatedBy

    has_one :duplicate, as: :duplicatable, dependent: :destroy

    scope :duplicates_to_process, lambda {
      left_outer_joins(:duplicate)
        .where("duplicates.processed_at IS NULL OR (#{table_name}.updated_at >= duplicates.processed_at)")
        .order(:id)
    }

    scope :relevant_duplicates, lambda {
      joins(:duplicate).where('score IS NOT NULL AND score >= ?', score_lower_threshold)
    }

    scope :high_duplicates, lambda {
      joins(:duplicate).where('score IS NOT NULL AND score >= ? AND sort <= 500', score_upper_threshold)
    }
  end

  module ClassMethods
    def duplicates_enabled?
      new.duplicate_model_config.present?
    end

    def score_upper_threshold
      return 50 unless duplicates_enabled?

      new.duplicate_model_config[:score_upper_threshold].presence || 50
    end

    def score_lower_threshold
      new.duplicate_model_config[:score_lower_threshold].presence || 15
    end

    def configured_duplicate_items
      new.duplicate_model_config[:additional_items].presence || []
    end

    def use_birth_date?
      new.respond_to?(:birth_date)
    end

    def use_address?
      new.respond_to?(:address_1) && !new.duplicates_bypass_address?
    end

    def use_first_last_name?
      new.respond_to?(:first_name)
    end

    def allow_merge_all?
      new.duplicate_model_config[:allow_merge_all].nil? ? false : new.duplicate_model_config[:allow_merge_all]
    end

    def additional_duplicate_items
      [{ name: :company_name, label: 'Company Name', type: :levenshtein, display_only: false, weight: 10 },
       { name: :email, label: 'Email', type: :string, display_only: false, weight: 20 },
       { name: :phone_number,
         label: 'Phone #',
         type: :string,
         display_only: false,
         weight: new.duplicate_other_weight },
       { name: :mobile_phone,
         label: 'Mobile Phone',
         type: :string,
         display_only: false,
         weight: new.duplicate_other_weight },
       { name: :fax_number,
         label: 'Fax #',
         type: :string,
         display_only: false,
         weight: 10 }] + configured_duplicate_items
    end

    def applicable_duplicate_items
      additional_duplicate_items.select { |item| new.respond_to?(item[:name]) }
    end

    def notify_high_duplicates
      all_records = all.size
      return unless all_records.positive?

      duplicate_records = high_duplicates.count
      percentage = (duplicate_records / (all_records * 1.0))
      return unless percentage > duplicate_notify_threshold

      Notifications::HighDuplicatesNotification.main(threshold: duplicate_notify_threshold,
                                                     percentage: percentage,
                                                     model_name: to_s).notify!
    end

    def duplicate_notify_threshold
      new.duplicate_model_config[:notify_threshold].presence || 0.01
    end
  end

  def process_duplicates(bypass_notifications: false)
    DuplicatesProcessor.new(class_name, bypass_notifications: bypass_notifications).record!(self)
  end

  def duplicate_fields
    fields = {}

    fields['Name'] = "#{first_name}, #{last_name}" if model_klass.use_first_last_name?
    fields['Address'] = full_address if model_klass.use_address? && respond_to?(:full_address)
    fields['Birth Date'] = birth_date.presence if model_klass.use_birth_date?
    model_klass.applicable_duplicate_items.each { |item| fields[item[:label]] = duplicate_item_display(item) }

    fields
  end

  def duplicate_item_display(item)
    return send(item[:name]) unless item[:type] == :association

    association = item[:name].to_s.gsub('_id', '')
    send(association)&.to_s
  end

  def find_duplicates
    items = DuplicatesMatcher.new(self).matches.reject do |contact|
      contact[:score] < self.class.score_lower_threshold
    end

    return if items.empty?

    items.map { |item| self.class.find(item[:id]) }
  end

  def reset_duplicates
    if duplicate.present?
      duplicate.destroy!
      reload
    end

    process_duplicates bypass_notifications: true
  end

  def duplicates
    return [] if duplicate.blank? || duplicate.duplicates_info.blank?

    dupes = JSON.parse(duplicate.duplicates_info).select { |item| item['score'] >= self.class.score_lower_threshold }
    contacts = []

    dupes.each do |dupe|
      contact = model_klass.find_by(id: dupe['id'])
      next if contact.blank?

      contacts.push(record: contact, score: dupe['score'])
    end

    contacts.sort_by { |item| item[:score] }.reverse
  end

  def not_duplicate(other_record)
    set_not_duplicate self, other_record
    set_not_duplicate other_record, self
  end

  def create_or_update_metadata!(attributes, bypass_notifications: false)
    if duplicate.blank?
      record = Duplicate.create! attributes.merge(processed_at: Time.current, duplicatable: self)
      record.notify! unless bypass_notifications
    else
      duplicate.update! attributes.merge(processed_at: Time.current)
    end
  end

  def can_merge_duplicate?(_new_record)
    # override as needed in models
    true
  end

  def clean_up_duplicate(_new_record)
    # override as needed in models
  end

  def duplicate_other_weight
    duplicate_model_config[:other_weight].presence || 20
  end

  def duplicates_bypass_address?
    duplicate_model_config[:bypass_address].nil? ? false : duplicate_model_config[:bypass_address]
  end

  def duplicate_model_config
    RadCommon::AppInfo.new.duplicate_model_config(self.class.name)
  end

  def merge_duplicates(duplicate_keys, user)
    error = nil

    ActiveRecord::Base.transaction do
      duplicate_keys.each do |key|
        error = fix_duplicate(key, user)
        break if error
      end
    end

    if error.present?
      [:error, "Unable to process duplicates: #{error}"]
    else
      process_duplicates
      [:success, "The duplicates for #{self.class} '#{self}' were successfully resolved."]
    end
  end

  def no_matches
    if duplicate.blank? || duplicate.duplicates_not.blank?
      []
    else
      JSON.parse(duplicate.duplicates_not)
    end
  end

  private

    def model_klass
      class_name.constantize
    end

    def class_name
      self.class.to_s
    end

    def table_name
      "#{self.class.to_s.underscore}s"
    end

    def set_not_duplicate(record_1, record_2)
      items = record_1.no_matches
      items.push(record_2.id)
      items = items.uniq

      record_1.create_or_update_metadata! duplicates_not: items.to_json
      record_1.reload
      record_1.process_duplicates
    end

    def fix_duplicate(key, user)
      duplicate_record = model_klass.find_by(id: key)

      if duplicate_record.blank?
        return 'Invalid record data, perhaps something has changed or another user has resolved these duplicates.'
      end

      return 'The records are the same record.' if duplicate_record.id == id

      unless Pundit.policy!(user, duplicate_record).destroy?
        return 'You do not have authorization to merge these duplicates.'
      end

      status, message = duplicate_record.can_merge_duplicate?(self)
      return message unless status

      duplicate_record.clean_up_duplicate(self)
      duplicate_record.reload

      return nil if duplicate_record.destroy

      'Could not remove the unused duplicate record ' \
        "id #{duplicate_record.id}: #{duplicate_record.errors.full_messages.join(', ')}"
    end
end
