ActiveRecordDoctor.configure do
  detector :incorrect_dependent_option, enabled: false
  detector :unindexed_foreign_keys, ignore_tables: %w[notification_settings notification_security_roles user_clients]
  detector :undefined_table_references, ignore_models: %w[ActionMailbox::Record ActionMailbox::InboundEmail]
  detector :missing_presence_validation, enabled: false

  # TODO: should these indexes be removed?
  detector :extraneous_indexes,
           ignore_indexes: %w[index_saved_search_filters_on_user_id index_user_security_roles_on_security_role_id]
end
