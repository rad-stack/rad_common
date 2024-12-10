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

ActiveRecord::Schema.define(version: 2023_03_24_202030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attorneys", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.string "company_name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.string "address_1", null: false
    t.string "address_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "address_metadata"
  end

  create_table "audits", id: :serial, force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.text "valid_user_domains", default: [], null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "phone_number", limit: 255, null: false
    t.string "website", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "address_1", limit: 255, null: false
    t.string "address_2", limit: 255
    t.string "city", limit: 255, null: false
    t.string "state", limit: 255, null: false
    t.string "zipcode", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "validity_checked_at"
    t.text "valid_user_domains", default: [], null: false, array: true
    t.string "timezone", null: false
    t.integer "address_requests_made", default: 0, null: false
    t.jsonb "address_metadata"
  end

  create_table "divisions", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "division_status"
    t.boolean "notify", default: false, null: false
    t.string "timezone"
    t.decimal "hourly_rate", precision: 8, scale: 2, default: "0.0", null: false
    t.string "additional_info"
    t.date "date_established"
    t.string "invoice_email"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_divisions_on_category_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "processed_at", null: false
    t.index ["duplicatable_type", "duplicatable_id"], name: "index_duplicates_on_duplicatable_type_and_duplicatable_id", unique: true
  end

  create_table "login_activities", force: :cascade do |t|
    t.string "scope"
    t.string "strategy"
    t.string "identity"
    t.boolean "success"
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
    t.datetime "created_at"
    t.index ["identity"], name: "index_login_activities_on_identity"
    t.index ["ip"], name: "index_login_activities_on_ip"
    t.index ["user_type", "user_id"], name: "index_login_activities_on_user_type_and_user_id"
  end

  create_table "notification_security_roles", force: :cascade do |t|
    t.integer "security_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notification_type_id", null: false
    t.index ["notification_type_id", "security_role_id"], name: "unique_notification_roles", unique: true
  end

  create_table "notification_settings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "enabled", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notification_type_id", null: false
    t.boolean "email", default: false, null: false
    t.boolean "feed", default: false, null: false
    t.boolean "sms", default: false, null: false
    t.index ["notification_type_id", "user_id"], name: "index_notification_settings_on_notification_type_id_and_user_id", unique: true
  end

  create_table "notification_types", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["type"], name: "index_notification_types_on_type", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "notification_type_id", null: false
    t.string "content", null: false
    t.boolean "unread", default: true, null: false
    t.string "record_type"
    t.bigint "record_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_type_id"], name: "index_notifications_on_notification_type_id"
    t.index ["record_type", "record_id"], name: "index_notifications_on_record_type_and_record_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.string "password_salt"
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable"
  end

  create_table "security_roles", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "create_division", default: false, null: false
    t.boolean "read_division", default: false, null: false
    t.boolean "update_division", default: false, null: false
    t.boolean "delete_division", default: false, null: false
    t.boolean "external", default: false, null: false
    t.boolean "manage_user", default: false, null: false
    t.boolean "allow_sign_up", default: false, null: false
    t.boolean "allow_invite", default: false, null: false
    t.index ["name"], name: "index_security_roles_on_name", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  create_table "system_messages", force: :cascade do |t|
    t.text "sms_message_body"
    t.integer "user_id", null: false
    t.integer "send_to", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "message_type", null: false
    t.integer "security_role_id"
    t.index ["security_role_id"], name: "index_system_messages_on_security_role_id"
    t.index ["user_id"], name: "index_system_messages_on_user_id"
  end

  create_table "twilio_logs", force: :cascade do |t|
    t.string "from_number", null: false
    t.string "to_number", null: false
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.string "message", null: false
    t.string "media_url"
    t.boolean "success", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "opt_out_message_sent", default: false, null: false
    t.index ["created_at"], name: "index_twilio_logs_on_created_at"
    t.index ["from_number"], name: "index_twilio_logs_on_from_number"
    t.index ["from_user_id"], name: "index_twilio_logs_on_from_user_id"
    t.index ["opt_out_message_sent"], name: "index_twilio_logs_on_opt_out_message_sent"
    t.index ["success"], name: "index_twilio_logs_on_success"
    t.index ["to_number"], name: "index_twilio_logs_on_to_number"
    t.index ["to_user_id"], name: "index_twilio_logs_on_to_user_id"
  end

  create_table "user_clients", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "client_id"], name: "index_user_clients_on_user_id_and_client_id", unique: true
  end

  create_table "user_security_roles", id: :serial, force: :cascade do |t|
    t.integer "security_role_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["security_role_id", "user_id"], name: "index_user_security_roles_on_security_role_id_and_user_id", unique: true
    t.index ["security_role_id"], name: "index_user_security_roles_on_security_role_id"
    t.index ["user_id"], name: "index_user_security_roles_on_user_id"
  end

  create_table "user_statuses", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: false, null: false
    t.boolean "validate_email_phone", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_statuses_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.string "mobile_phone", limit: 255
    t.string "timezone", limit: 255, null: false
    t.string "global_search_default", limit: 255
    t.integer "user_status_id", null: false
    t.string "authy_id"
    t.datetime "last_sign_in_with_twilio_verify"
    t.boolean "twilio_verify_enabled", default: true, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "external", default: false, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "password_changed_at"
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.jsonb "filter_defaults"
    t.boolean "twilio_verify_sms", default: true, null: false
    t.string "twilio_totp_factor_sid"
    t.index ["authy_id"], name: "index_users_on_authy_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
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
  add_foreign_key "audits", "users"
  add_foreign_key "divisions", "categories"
  add_foreign_key "divisions", "users", column: "owner_id"
  add_foreign_key "notification_security_roles", "notification_types"
  add_foreign_key "notification_security_roles", "security_roles"
  add_foreign_key "notification_settings", "notification_types"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "notifications", "notification_types"
  add_foreign_key "notifications", "users"
  add_foreign_key "system_messages", "security_roles"
  add_foreign_key "system_messages", "users"
  add_foreign_key "twilio_logs", "users", column: "from_user_id"
  add_foreign_key "twilio_logs", "users", column: "to_user_id"
  add_foreign_key "user_clients", "clients"
  add_foreign_key "user_clients", "users"
  add_foreign_key "user_security_roles", "security_roles"
  add_foreign_key "user_security_roles", "users"
  add_foreign_key "users", "user_statuses"
  add_foreign_key "users", "users", column: "invited_by_id"
end
