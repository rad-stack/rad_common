module Contactable
  extend ActiveSupport::Concern

  included do
    validates :zipcode, format: /\A[0-9]{5}(?:-[0-9]{4})?\z/, allow_nil: true, unless: :canadian?

    validate :validate_state
    validate :validate_address_2
    validate :validate_metadata
    validate :validate_address, if: :run_smarty?

    before_validation :maybe_standardize_address
  end

  def maybe_standardize_address
    if address?
      standardize_address if run_smarty?
    else
      self.address_metadata = nil
    end
  end

  def street_addresses
    [address_1, address_2].compact_blank.join(', ').to_s
  end

  def city_state_zip
    [city_state, zipcode].compact_blank.join(' ').presence
  end

  def full_address
    [street_addresses, city_state_zip].compact_blank.join(', ').presence
  end

  def full_address_no_commas
    [address_1, address_2, city, state, zipcode].compact_blank.join(' ').to_s
  end

  def clear_address_changes!
    return if address_metadata.blank?

    update_column :address_metadata, address_metadata.except('changes')
  end

  def bypass_address_validation?
    address_metadata.present? && address_metadata['bypass_address_validation']
  end

  def bypass_address_validation=(value)
    self.address_metadata ||= {}
    self.address_metadata['bypass_address_validation'] = value
  end

  def address_problems
    return if address_metadata.blank?

    address_metadata['problems']
  end

  def address_changes
    return if address_metadata.blank?
    return if address_metadata['changes'].blank?

    address_metadata['changes'].values.join(', ')
  end

  private

    def run_smarty?
      # we can and probably should enable this for Canadian addresses, just capping the effort for now
      return false if running_global_validity || !RadConfig.smarty_enabled? || bypass_address_validation? || canadian?

      any_address_changes?
    end

    def canadian?
      state.present? && StateOptions.valid?(state) && StateOptions.canadian?(state)
    end

    def validate_state
      errors.add(:state, "isn't a valid state") if state.present? && !StateOptions.valid?(state)
    end

    def validate_address_2
      errors.add :address_2, 'must be blank when address 1 is blank' if address_1.blank? && address_2.present?
    end

    def validate_metadata
      return unless address_metadata.present? && !address?

      errors.add :address_metadata, 'must be blank when address is blank'
    end

    def validate_address
      errors.add(:address_1, 'is not a valid address') unless valid_address?
    end

    def valid_address?
      return true if address_metadata.blank?

      address_metadata['valid']
    end

    def address?
      (address_1.present? && city.present? && state.present? && zipcode.present?)
    end

    def any_address_changes?
      address_1_changed? || address_2_changed? || city_changed? || zipcode_changed? || state_changed?
    end

    def city_state
      [city, state].compact_blank.join(', ').presence
    end

    def apply_standardized_address(result)
      apply_changes result

      self.address_1 = result.address_1
      self.address_2 = result.address_2
      self.city = result.city
      self.state = result.state
      self.zipcode = result.zipcode

      self.address_metadata ||= {}
      self.address_metadata['problems'] = result.address_problems if result.address_problems.present?
      self.address_metadata['valid'] = true
    end

    def standardize_address
      result = SmartyAddress.new({ address_1: address_1,
                                   address_2: address_2,
                                   city: city,
                                   state: state,
                                   zipcode: zipcode }, upcase?).call

      return unless result

      if result.valid_address?
        apply_standardized_address(result)
      else
        self.address_metadata ||= {}
        self.address_metadata['valid'] = false
        self.address_metadata['problems'] = result.address_problems if result.address_problems.present?
      end
    end

    def upcase?
      false
    end

    def apply_changes(result)
      changes_hash = {}

      %w[address_1 address_2 city state zipcode].each do |field|
        next if attributes[field].blank? && result.send(field).blank?
        next if attributes[field]&.downcase == result.send(field)&.downcase

        changes_hash[field] = attributes[field]
      end

      self.address_metadata ||= {}
      self.address_metadata['changes'] = changes_hash if changes_hash.present?
    end
end
