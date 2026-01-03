# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_20_171951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assistant_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.jsonb "log"
    t.string "contextable_type"
    t.bigint "contextable_id"
    t.string "chat_scope_type"
    t.bigint "chat_scope_id"
    t.integer "status", default: 1, null: false
    t.string "chat_class", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_scope_type", "chat_scope_id"], name: "index_assistant_sessions_on_chat_scope"
    t.index ["contextable_type", "contextable_id"], name: "index_assistant_sessions_on_contextable"
    t.index ["user_id"], name: "index_assistant_sessions_on_user_id"
  end

  create_table "attorneys", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "company_name", null: false
    t.string "phone_number"
    t.string "email", null: false
    t.string "address_1", null: false
    t.string "address_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "mobile_phone"
    t.jsonb "address_metadata"
    t.index ["first_name", "last_name", "mobile_phone"], name: "index_attorneys_on_first_name_and_last_name_and_mobile_phone", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.bigint "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at", precision: nil, null: false
    t.jsonb "audited_changes"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.text "valid_user_domains", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "business_type"
    t.index ["name", "business_type"], name: "index_clients_on_name_and_business_type", unique: true, nulls_not_distinct: true
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "website", null: false
    t.string "email", null: false
    t.string "address_1", null: false
    t.string "address_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "validity_checked_at", precision: nil
    t.text "valid_user_domains", default: [], null: false, array: true
    t.string "timezone", null: false
    t.integer "address_requests_made", default: 0, null: false
    t.jsonb "address_metadata"
  end

  create_table "contact_log_recipients", force: :cascade do |t|
    t.bigint "contact_log_id", null: false
    t.bigint "to_user_id"
    t.string "email"
    t.string "phone_number"
    t.integer "email_type"
    t.integer "sms_status"
    t.boolean "success", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "email_status"
    t.string "sendgrid_reason"
    t.boolean "notify_on_fail", default: true, null: false
    t.boolean "sms_false_positive", default: false, null: false
    t.integer "fax_status"
    t.string "fax_error_message"
    t.index ["contact_log_id"], name: "index_contact_log_recipients_on_contact_log_id"
    t.index ["created_at"], name: "index_contact_log_recipients_on_created_at"
    t.index ["email"], name: "index_contact_log_recipients_on_email"
    t.index ["phone_number"], name: "index_contact_log_recipients_on_phone_number"
    t.index ["to_user_id"], name: "index_contact_log_recipients_on_to_user_id"
  end

  create_table "contact_logs", force: :cascade do |t|
    t.string "from_number"
    t.bigint "from_user_id"
    t.string "sms_media_url"
    t.boolean "sent", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sms_opt_out_message_sent", default: false, null: false
    t.string "sms_message_id"
    t.integer "contact_direction"
    t.string "from_email"
    t.integer "service_type", default: 0, null: false
    t.string "record_type"
    t.bigint "record_id"
    t.string "content"
    t.string "fax_message_id"
    t.index ["created_at"], name: "index_contact_logs_on_created_at"
    t.index ["from_number"], name: "index_contact_logs_on_from_number"
    t.index ["from_user_id"], name: "index_contact_logs_on_from_user_id"
    t.index ["record_type", "record_id"], name: "index_contact_logs_on_record"
    t.index ["sent"], name: "index_contact_logs_on_sent"
    t.index ["service_type"], name: "index_contact_logs_on_service_type"
    t.index ["sms_message_id"], name: "index_contact_logs_on_sms_message_id"
    t.index ["sms_opt_out_message_sent"], name: "index_contact_logs_on_sms_opt_out_message_sent"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "division_status"
    t.boolean "notify", default: false, null: false
    t.string "timezone"
    t.decimal "hourly_rate", precision: 8, scale: 2, default: "0.0", null: false
    t.string "additional_info"
    t.date "date_established"
    t.string "invoice_email"
    t.bigint "category_id"
    t.string "tags", default: [], null: false, array: true
    t.string "api_key"
    t.index ["category_id"], name: "index_divisions_on_category_id"
    t.index ["created_at"], name: "index_divisions_on_created_at"
    t.index ["name"], name: "index_divisions_on_name", unique: true, where: "(division_status = 0)"
    t.index ["owner_id"], name: "index_divisions_on_owner_id"
  end

  create_table "duplicates", force: :cascade do |t|
    t.string "duplicatable_type", null: false
    t.bigint "duplicatable_id", null: false
    t.text "duplicates_info"
    t.text "duplicates_not"
    t.integer "score"
    t.integer "sort", default: 500, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "processed_at", precision: nil, null: false
    t.index ["duplicatable_type", "duplicatable_id"], name: "index_duplicates_on_duplicatable_type_and_duplicatable_id", unique: true
  end

  create_table "embeddings", force: :cascade do |t|
    t.string "embeddable_type", null: false
    t.bigint "embeddable_id", null: false
    t.vector "embedding", limit: 1536, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embeddable_type", "embeddable_id"], name: "index_embeddings_on_embeddable_type_and_embeddable_id", unique: true
    t.index ["embedding"], name: "index_embeddings_on_embedding", opclass: :vector_cosine_ops, using: :hnsw
  end

  create_table "login_activities", force: :cascade do |t|
    t.string "scope"
    t.string "strategy"
    t.string "identity"
    t.boolean "success", default: false, null: false
    t.string "failure_reason"
    t.string "user_type"
    t.bigint "user_id"
    t.string "context"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "city"
    t.string "region"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: nil
    t.index ["identity"], name: "index_login_activities_on_identity"
    t.index ["ip"], name: "index_login_activities_on_ip"
    t.index ["user_type", "user_id"], name: "index_login_activities_on_user_type_and_user_id"
  end

  create_table "notification_security_roles", force: :cascade do |t|
    t.bigint "security_role_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "notification_type_id", null: false
    t.index ["notification_type_id", "security_role_id"], name: "unique_notification_roles", unique: true
    t.index ["notification_type_id"], name: "index_notification_security_roles_on_notification_type_id"
    t.index ["security_role_id"], name: "index_notification_security_roles_on_security_role_id"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "notification_type_id", null: false
    t.boolean "email", default: false, null: false
    t.boolean "feed", default: false, null: false
    t.boolean "sms", default: false, null: false
    t.index ["notification_type_id", "user_id"], name: "index_notification_settings_on_notification_type_id_and_user_id", unique: true
    t.index ["notification_type_id"], name: "index_notification_settings_on_notification_type_id"
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "notification_types", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: true, null: false
    t.string "bcc_recipient"
    t.index ["type"], name: "index_notification_types_on_type", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "notification_type_id", null: false
    t.string "content", null: false
    t.boolean "unread", default: true, null: false
    t.string "record_type"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_notifications_on_created_at"
    t.index ["notification_type_id"], name: "index_notifications_on_notification_type_id"
    t.index ["record_type", "record_id"], name: "index_notifications_on_record_type_and_record_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.string "password_salt"
    t.datetime "created_at", precision: nil
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "saved_search_filters", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.string "search_class", null: false
    t.jsonb "search_filters", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name", "search_class"], name: "unique_saved_search_filters", unique: true
    t.index ["user_id"], name: "index_saved_search_filters_on_user_id"
  end

  create_table "search_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "search_class", null: false
    t.integer "toggle_behavior"
    t.boolean "sticky_filters", default: false, null: false
    t.jsonb "search_filters", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "search_class"], name: "unique_search_preferences", unique: true
    t.index ["user_id"], name: "index_search_preferences_on_user_id"
  end

  create_table "security_roles", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "create_division", default: false, null: false
    t.boolean "external", default: false, null: false
    t.boolean "manage_user", default: false, null: false
    t.boolean "allow_sign_up", default: false, null: false
    t.boolean "allow_invite", default: false, null: false
    t.boolean "read_division", default: false, null: false
    t.boolean "update_division", default: false, null: false
    t.boolean "delete_division", default: false, null: false
    t.boolean "read_attorney", default: false, null: false
    t.boolean "two_factor_auth", default: true, null: false
    t.index ["name"], name: "index_security_roles_on_name", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  create_table "system_messages", force: :cascade do |t|
    t.text "sms_message_body"
    t.bigint "user_id", null: false
    t.integer "send_to", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "message_type", null: false
    t.bigint "security_role_id"
    t.index ["security_role_id"], name: "index_system_messages_on_security_role_id"
    t.index ["user_id"], name: "index_system_messages_on_user_id"
  end

  create_table "user_clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_user_clients_on_client_id"
    t.index ["user_id", "client_id"], name: "index_user_clients_on_user_id_and_client_id", unique: true
    t.index ["user_id"], name: "index_user_clients_on_user_id"
  end

  create_table "user_security_roles", force: :cascade do |t|
    t.bigint "security_role_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["security_role_id", "user_id"], name: "index_user_security_roles_on_security_role_id_and_user_id", unique: true
    t.index ["security_role_id"], name: "index_user_security_roles_on_security_role_id"
    t.index ["user_id"], name: "index_user_security_roles_on_user_id"
  end

  create_table "user_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.boolean "validate_email_phone", default: true, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_user_statuses_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mobile_phone"
    t.string "timezone", null: false
    t.string "global_search_default"
    t.bigint "user_status_id", null: false
    t.boolean "otp_required_for_login", default: true, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "external", default: false, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "password_changed_at", precision: nil
    t.datetime "last_activity_at", precision: nil
    t.datetime "expired_at", precision: nil
    t.boolean "profile_entered", default: false, null: false
    t.date "birth_date"
    t.string "language", default: "en", null: false
    t.string "detected_timezone"
    t.string "ignored_timezone"
    t.string "detected_timezone_js"
    t.string "otp_secret"
    t.integer "consumed_timestep"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["expired_at"], name: "index_users_on_expired_at"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["last_activity_at"], name: "index_users_on_last_activity_at"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["password_changed_at"], name: "index_users_on_password_changed_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_status_id"], name: "index_users_on_user_status_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assistant_sessions", "users"
  add_foreign_key "audits", "users"
  add_foreign_key "contact_log_recipients", "contact_logs"
  add_foreign_key "contact_log_recipients", "users", column: "to_user_id"
  add_foreign_key "contact_logs", "users", column: "from_user_id"
  add_foreign_key "divisions", "categories"
  add_foreign_key "divisions", "users", column: "owner_id"
  add_foreign_key "notification_security_roles", "notification_types"
  add_foreign_key "notification_security_roles", "security_roles"
  add_foreign_key "notification_settings", "notification_types"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "notifications", "notification_types"
  add_foreign_key "notifications", "users"
  add_foreign_key "saved_search_filters", "users"
  add_foreign_key "search_preferences", "users"
  add_foreign_key "system_messages", "security_roles"
  add_foreign_key "system_messages", "users"
  add_foreign_key "user_clients", "clients"
  add_foreign_key "user_clients", "users"
  add_foreign_key "user_security_roles", "security_roles"
  add_foreign_key "user_security_roles", "users"
  add_foreign_key "users", "user_statuses"
  add_foreign_key "users", "users", column: "invited_by_id"
end
