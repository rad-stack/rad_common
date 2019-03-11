# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_25_194928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string   "name",        :null=>false
    t.string   "record_type", :null=>false, :index=>{:name=>"index_active_storage_attachments_uniqueness", :with=>["record_id", "name", "blob_id"], :unique=>true}
    t.bigint   "record_id",   :null=>false
    t.bigint   "blob_id",     :null=>false, :index=>{:name=>"index_active_storage_attachments_on_blob_id"}
    t.datetime "created_at",  :null=>false
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string   "key",          :null=>false, :index=>{:name=>"index_active_storage_blobs_on_key", :unique=>true}
    t.string   "filename",     :null=>false
    t.string   "content_type"
    t.text     "metadata"
    t.bigint   "byte_size",    :null=>false
    t.string   "checksum",     :null=>false
    t.datetime "created_at",   :null=>false
  end

  create_table "audits", id: :serial, force: :cascade do |t|
    t.integer  "auditable_id",    :index=>{:name=>"auditable_index", :with=>["auditable_type"]}
    t.string   "auditable_type"
    t.integer  "associated_id",   :index=>{:name=>"associated_index", :with=>["associated_type"]}
    t.string   "associated_type"
    t.integer  "user_id",         :index=>{:name=>"user_index", :with=>["user_type"]}
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default=>0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid",    :index=>{:name=>"index_audits_on_request_uuid"}
    t.datetime "created_at",      :index=>{:name=>"index_audits_on_created_at"}
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string   "name",                :limit=>255, :null=>false
    t.string   "phone_number",        :limit=>255, :null=>false
    t.string   "website",             :limit=>255, :null=>false
    t.string   "email",               :limit=>255, :null=>false
    t.string   "address_1",           :limit=>255, :null=>false
    t.string   "address_2",           :limit=>255
    t.string   "city",                :limit=>255, :null=>false
    t.string   "state",               :limit=>255, :null=>false
    t.string   "zipcode",             :limit=>255, :null=>false
    t.datetime "created_at",          :null=>false
    t.datetime "updated_at",          :null=>false
    t.datetime "validity_checked_at"
    t.text     "valid_user_domains",  :default=>[], :array=>true
  end

  create_table "divisions", id: :serial, force: :cascade do |t|
    t.string   "name",            :null=>false
    t.string   "code",            :null=>false
    t.integer  "owner_id",        :null=>false, :index=>{:name=>"index_divisions_on_owner_id"}
    t.datetime "created_at",      :null=>false
    t.datetime "updated_at",      :null=>false
    t.integer  "division_status"
    t.boolean  "notify",          :default=>false, :null=>false
    t.string   "timezone"
  end

  create_table "security_roles", id: :serial, force: :cascade do |t|
    t.string   "name",            :null=>false, :index=>{:name=>"index_security_roles_on_name", :unique=>true}
    t.boolean  "admin",           :default=>false, :null=>false
    t.boolean  "read_user",       :default=>false, :null=>false
    t.boolean  "read_audit",      :default=>false, :null=>false
    t.datetime "created_at",      :null=>false
    t.datetime "updated_at",      :null=>false
    t.boolean  "create_division", :default=>false, :null=>false
    t.boolean  "read_division",   :default=>false, :null=>false
    t.boolean  "update_division", :default=>false, :null=>false
    t.boolean  "delete_division", :default=>false, :null=>false
  end

  create_table "security_roles_users", id: :serial, force: :cascade do |t|
    t.integer  "security_role_id", :null=>false, :index=>{:name=>"index_security_roles_users_on_security_role_id"}
    t.integer  "user_id",          :null=>false, :index=>{:name=>"index_security_roles_users_on_user_id"}
    t.datetime "created_at",       :null=>false
    t.datetime "updated_at",       :null=>false

    t.index ["security_role_id", "user_id"], :name=>"index_security_roles_users_on_security_role_id_and_user_id", :unique=>true
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       :null=>false, :index=>{:name=>"index_statuses_on_name", :unique=>true}
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "user_statuses", id: :serial, force: :cascade do |t|
    t.string   "name",           :null=>false, :index=>{:name=>"index_user_statuses_on_name", :unique=>true}
    t.boolean  "active",         :default=>false, :null=>false
    t.boolean  "validate_email", :default=>true, :null=>false
    t.datetime "created_at",     :null=>false
    t.datetime "updated_at",     :null=>false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string   "email",                   :limit=>255, :default=>"", :null=>false, :index=>{:name=>"index_users_on_email", :unique=>true}
    t.string   "encrypted_password",      :limit=>255, :default=>"", :null=>false
    t.string   "reset_password_token",    :limit=>255, :index=>{:name=>"index_users_on_reset_password_token", :unique=>true}
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default=>0, :null=>false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      :limit=>255
    t.string   "last_sign_in_ip",         :limit=>255
    t.datetime "created_at",              :null=>false
    t.datetime "updated_at",              :null=>false
    t.string   "confirmation_token",      :limit=>255, :index=>{:name=>"index_users_on_confirmation_token", :unique=>true}
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",       :limit=>255
    t.string   "first_name",              :limit=>255, :null=>false, :index=>{:name=>"index_users_on_first_name"}
    t.string   "last_name",               :limit=>255, :null=>false, :index=>{:name=>"index_users_on_last_name"}
    t.string   "mobile_phone",            :limit=>255
    t.string   "timezone",                :limit=>255
    t.string   "global_search_default",   :limit=>255
    t.boolean  "super_admin",             :default=>false, :null=>false
    t.integer  "user_status_id",          :null=>false, :index=>{:name=>"index_users_on_user_status_id"}
    t.boolean  "super_search_default",    :default=>false, :null=>false
    t.string   "authy_id",                :index=>{:name=>"index_users_on_authy_id"}
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",           :default=>false, :null=>false
    t.string   "firebase_id"
    t.string   "invitation_token",        :index=>{:name=>"index_users_on_invitation_token", :unique=>true}
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id",           :index=>{:name=>"index_users_on_invited_by_id"}
    t.integer  "invitations_count",       :default=>0, :index=>{:name=>"index_users_on_invitations_count"}
    t.boolean  "external",                :default=>false, :null=>false
  end

  add_foreign_key "audits", "users"
  add_foreign_key "divisions", "users", column: "owner_id"
  add_foreign_key "security_roles_users", "security_roles"
  add_foreign_key "security_roles_users", "users"
  add_foreign_key "users", "user_statuses"
  add_foreign_key "users", "users", column: "invited_by_id"
end
