class AddressProblem
  def self.enabled?
    RadicalConfig.smarty_enabled?
  end

  def self.records
    AddressProblem.new.records
  end

  def records
    queries.flatten
  end

  private

    def queries
      model_names.map { |item| item.constantize.where.not(address_metadata: nil) }
    end

    def model_names
      RadCommon::AppInfo.new.contactable_models
    end
end
