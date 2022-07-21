module Contactable
  extend ActiveSupport::Concern

  included do
    validates :zipcode, numericality: true, length: { is: 5 }, allow_nil: true
    validates :state, length: { is: 2 }, allow_nil: true

    before_validation :maybe_standardize_address
  end

  def get_address(mode)
    return unless address?

    add_1 = address_1
    components = [add_1]
    components.push(address_2) if address_2.present? && mode > 1
    components += [city, state, zipcode]

    components.join(', ')
  end

  def maybe_standardize_address
    return if running_global_validity || bypass_address_validation?
    return unless address_api_enabled? && address? && any_address_changes?

    standardize_address
  end

  def street_addresses
    [address_1, address_2].reject(&:blank?).join(', ').to_s
  end

  def city_state_zip
    city_state = [city, state].compact.join(', ').presence
    [city_state, zipcode].compact.join(' ').presence
  end

  def full_address
    [street_addresses, city_state_zip].compact.join(', ').presence
  end

  private

    def address?
      (address_1.present? && city.present? && state.present? && zipcode.present?)
    end

    def any_address_changes?
      address_1_changed? || address_2_changed? || city_changed? || zipcode_changed? || state_changed?
    end

    def apply_standardized_address(result)
      self.address_1 = result.address_line_1
      self.address_2 = result.address_line_2
      self.city = result.city
      self.state = result.state
      self.zipcode = result.zip_code
      self.address_problems = nil
    end

    def standardize_address
      result = address_api_class_name.constantize.new({ primary_line: address_1,
                                                        secondary_line: address_2,
                                                        city: city,
                                                        state: state,
                                                        zip_code: zipcode }).call

      return unless result

      result.deliverable? ? apply_standardized_address(result) : self.address_problems = result.deliverability
    end

    def address_api_class_name
      return 'SmartyAddress' if RadicalConfig.smarty_enabled?

      'LobAddress'
    end

    def address_api_enabled?
      RadicalConfig.smarty_enabled? || RadicalConfig.lob_enabled?
    end
end
