module RadCompany
  extend ActiveSupport::Concern

  included do
    include RadCommonCompany
  end

  module ClassMethods
    def super_company
      Company.main
    end
  end

  def members
    User.active.order(:id)
  end

  def check_global_validity
    error_messages = []

    exclude_models  = [ActiveRecord::SchemaMigration, ApplicationRecord] + Rails.application.config.global_validity_exclude

    Rails.application.eager_load!
    all_models = ActiveRecord::Base.descendants
    models = all_models - exclude_models

    models.each do |model|
      unless exclude_models.include?(model.to_s)
        error_messages = error_messages.concat(check_model(model))
      end
    end

    specific_queries = Rails.application.config.global_validity_include

    specific_queries.each { |query| error_messages = error_messages.concat(check_query_records(query)) }

    error_messages
  end
end
