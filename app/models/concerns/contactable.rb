module Contactable
  extend ActiveSupport::Concern

  included do
    validates :zipcode, format: /\A[0-9]{5}(?:-[0-9]{4})?\z/, allow_nil: true

    validate :validate_state
    validate :validate_address_2

    before_validation :maybe_standardize_address
  end

  def maybe_standardize_address
    return if running_global_validity || bypass_address_validation?
    return unless RadicalConfig.smarty_enabled? && address? && any_address_changes?

    standardize_address
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
    update_column :address_changes, nil
  end

  private

    def validate_state
      return if city_model_variant?

      errors.add(:state, "isn't a valid state") if state.present? && !StateOptions.valid?(state)
    end

    def validate_address_2
      errors.add :address_2, 'must be blank when address 1 is blank' if address_1.blank? && address_2.present?
    end

    def address?
      (address_1.present? && city.present? && state.present? && zipcode.present?)
    end

    def any_address_changes?
      return city_model_variant_changes? if city_model_variant?

      address_1_changed? || address_2_changed? || city_changed? || zipcode_changed? || state_changed?
    end

    def city_model_variant_changes?
      # one project uses city/state models

      address_1_changed? || address_2_changed? || city_id_changed? || zipcode_changed?
    end

    def city_state
      return city.to_s if city_model_variant?

      [city, state].compact_blank.join(', ').presence
    end

    def apply_standardized_address(result)
      self.address_changes = apply_changes(result)

      self.address_1 = result.address_1
      self.address_2 = result.address_2

      if city_model_variant?
        self.city = City.find_or_create_by!(state: state_record(result.state), name: result.city)
      else
        self.city = result.city
        self.state = result.state
      end

      self.zipcode = result.zipcode

      self.address_problems = nil
    end

    def standardize_address
      result = SmartyAddress.new({ address_1: address_1,
                                   address_2: address_2,
                                   city: city,
                                   state: state,
                                   zipcode: zipcode }).call

      return unless result

      if result.valid_address?
        apply_standardized_address(result)
      else
        self.address_problems = result.address_problems
      end
    end

    def apply_changes(result)
      changes_hash = {}

      %w[address_1 address_2 city state zipcode].each do |field|
        next if attributes[field].blank? && result.send(field).blank?
        next if attributes[field]&.downcase == result.send(field)&.downcase

        changes_hash[field] = attributes[field]
      end

      changes_hash
    end

    def city_model_variant?
      # one project uses city/state models

      respond_to?(:city_id)
    end

    def state_record(state_code)
      # only used for the city_model_variant on the one project

      state_name = StateOptions.options.select { |item| item.last == state_code }.first.first
      this_state = State.find_by(name: state_name)
      raise "Couldn't find state: #{state_name}" if this_state.blank?

      this_state
    end
end
