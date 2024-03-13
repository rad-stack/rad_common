ActiveRecordDoctor.configure do
  detector :incorrect_dependent_option, enabled: false
  detector :missing_presence_validation, enabled: false
  detector :undefined_table_references, ignore_models: %w[ActionMailbox::Record ActionMailbox::InboundEmail]

  detector :extraneous_indexes,
           ignore_indexes: %w[index_notification_settings_on_notification_type_id
                              index_saved_search_filters_on_user_id
                              index_user_clients_on_user_id
                              index_user_security_roles_on_security_role_id
                              index_notification_security_roles_on_notification_type_id]
end
