# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150510141418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "encrypted_street1"
    t.string   "encrypted_street2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "person_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "addresses", ["person_id"], name: "index_addresses_on_person_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "apikey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_on_event"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
  end

  add_index "admin_users", ["apikey"], name: "index_admin_users_on_apikey", unique: true, using: :btree
  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "airlines", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "awards", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "branch_id"
  end

  add_index "awards", ["branch_id"], name: "index_awards_on_branch_id", using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contact_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contact_relationships", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "full_name"
    t.integer  "address_id"
    t.integer  "person_id"
    t.string   "encrypted_phone"
    t.string   "encrypted_alternate_phone"
    t.string   "encrypted_email"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "contact_category_id"
    t.integer  "contact_relationship_id"
  end

  add_index "contacts", ["address_id"], name: "index_contacts_on_address_id", using: :btree
  add_index "contacts", ["contact_category_id"], name: "index_contacts_on_contact_category_id", using: :btree
  add_index "contacts", ["contact_relationship_id"], name: "index_contacts_on_contact_relationship_id", using: :btree
  add_index "contacts", ["person_id"], name: "index_contacts_on_person_id", using: :btree

  create_table "day_of_flights", force: :cascade do |t|
    t.date     "flies_on"
    t.integer  "war_id"
    t.text     "special_instruction"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "group_number"
    t.integer  "tickets_purchased"
    t.string   "notification_key"
  end

  add_index "day_of_flights", ["war_id"], name: "index_day_of_flights_on_war_id", using: :btree

  create_table "day_of_flights_volunteers", force: :cascade do |t|
    t.integer  "day_of_flight_id"
    t.integer  "person_id"
    t.integer  "flight_responsibility_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "day_of_flights_volunteers", ["day_of_flight_id"], name: "index_day_of_flights_volunteers_on_day_of_flight_id", using: :btree
  add_index "day_of_flights_volunteers", ["flight_responsibility_id"], name: "index_day_of_flights_volunteers_on_flight_responsibility_id", using: :btree
  add_index "day_of_flights_volunteers", ["person_id"], name: "index_day_of_flights_volunteers_on_person_id", using: :btree

  create_table "flight_attachments", force: :cascade do |t|
    t.integer  "day_of_flight_id"
    t.string   "name"
    t.string   "comments"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "attachment"
  end

  add_index "flight_attachments", ["day_of_flight_id"], name: "index_flight_attachments_on_day_of_flight_id", using: :btree

  create_table "flight_details", force: :cascade do |t|
    t.string   "destination"
    t.string   "departs_from"
    t.datetime "arrives_at"
    t.datetime "departs_at"
    t.string   "flight_number"
    t.integer  "airline_id"
    t.integer  "day_of_flight_id"
    t.string   "departure_gate"
    t.string   "arrival_gate"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "flight_details", ["airline_id"], name: "index_flight_details_on_airline_id", using: :btree
  add_index "flight_details", ["day_of_flight_id"], name: "index_flight_details_on_day_of_flight_id", using: :btree

  create_table "flight_responsibilities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "role_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "flight_responsibilities", ["role_id"], name: "index_flight_responsibilities_on_role_id", using: :btree

  create_table "medical_allergies", force: :cascade do |t|
    t.string   "medical_allergy"
    t.integer  "person_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "medical_allergies", ["person_id"], name: "index_medical_allergies_on_person_id", using: :btree

  create_table "medical_condition_names", force: :cascade do |t|
    t.string   "encrypted_name"
    t.text     "description"
    t.integer  "medical_condition_type_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "medical_condition_names", ["medical_condition_type_id"], name: "index_medical_condition_names_on_medical_condition_type_id", using: :btree

  create_table "medical_condition_types", force: :cascade do |t|
    t.string   "encrypted_name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "medical_conditions", force: :cascade do |t|
    t.string   "encrypted_diagnosed_at"
    t.string   "encrypted_last_occurrence"
    t.text     "encrypted_comment"
    t.integer  "person_id"
    t.integer  "medical_condition_type_id"
    t.integer  "medical_condition_name_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "medical_conditions", ["medical_condition_name_id"], name: "index_medical_conditions_on_medical_condition_name_id", using: :btree
  add_index "medical_conditions", ["medical_condition_type_id"], name: "index_medical_conditions_on_medical_condition_type_id", using: :btree
  add_index "medical_conditions", ["person_id"], name: "index_medical_conditions_on_person_id", using: :btree

  create_table "medication_routes", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "medications", force: :cascade do |t|
    t.string   "medication"
    t.string   "dose"
    t.string   "frequency"
    t.integer  "person_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "medication_route_id"
  end

  add_index "medications", ["medication_route_id"], name: "index_medications_on_medication_route_id", using: :btree
  add_index "medications", ["person_id"], name: "index_medications_on_person_id", using: :btree

  create_table "mobility_devices", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "name_suffixes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "encrypted_email"
    t.string   "encrypted_phone"
    t.string   "uuid"
    t.string   "encrypted_birth_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "war_id"
    t.integer  "shirt_size_id"
    t.boolean  "release_info"
    t.boolean  "tlc"
    t.integer  "day_of_flight_id"
    t.boolean  "veteran"
    t.boolean  "guardian"
    t.integer  "person_status_id"
    t.integer  "mobility_device_id"
    t.boolean  "applied_online"
    t.date     "application_date"
    t.string   "type"
    t.integer  "guardian_id"
    t.string   "encrypted_cell_phone"
    t.string   "encrypted_work_phone"
    t.string   "encrypted_work_email"
    t.integer  "name_suffix_id"
  end

  add_index "people", ["day_of_flight_id"], name: "index_people_on_day_of_flight_id", using: :btree
  add_index "people", ["mobility_device_id"], name: "index_people_on_mobility_device_id", using: :btree
  add_index "people", ["name_suffix_id"], name: "index_people_on_name_suffix_id", using: :btree
  add_index "people", ["person_status_id"], name: "index_people_on_person_status_id", using: :btree
  add_index "people", ["shirt_size_id"], name: "index_people_on_shirt_size_id", using: :btree
  add_index "people", ["war_id"], name: "index_people_on_war_id", using: :btree

  create_table "people_attachments", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "attachment"
    t.string   "name"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people_attachments", ["person_id"], name: "index_people_attachments_on_person_id", using: :btree

  create_table "person_statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rank_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "rank_type_id"
    t.integer  "branch_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "abbreviation"
  end

  add_index "ranks", ["branch_id"], name: "index_ranks_on_branch_id", using: :btree
  add_index "ranks", ["rank_type_id"], name: "index_ranks_on_rank_type_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "short_code"
  end

  create_table "service_awards", force: :cascade do |t|
    t.integer  "quantity"
    t.text     "comment"
    t.integer  "service_history_id"
    t.integer  "award_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "service_awards", ["award_id"], name: "index_service_awards_on_award_id", using: :btree
  add_index "service_awards", ["service_history_id"], name: "index_service_awards_on_service_history_id", using: :btree

  create_table "service_histories", force: :cascade do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "activity"
    t.text     "story"
    t.integer  "branch_id"
    t.integer  "rank_id"
    t.integer  "rank_type_id"
    t.integer  "person_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "service_histories", ["branch_id"], name: "index_service_histories_on_branch_id", using: :btree
  add_index "service_histories", ["person_id"], name: "index_service_histories_on_person_id", using: :btree
  add_index "service_histories", ["rank_id"], name: "index_service_histories_on_rank_id", using: :btree
  add_index "service_histories", ["rank_type_id"], name: "index_service_histories_on_rank_type_id", using: :btree

  create_table "shirt_sizes", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "simple_pages", force: :cascade do |t|
    t.string   "key"
    t.string   "title"
    t.text     "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_messages", force: :cascade do |t|
    t.string   "to_country"
    t.string   "to_state"
    t.string   "sms_message_sid"
    t.string   "num_media"
    t.string   "to_city"
    t.string   "from_zip"
    t.string   "sms_sid"
    t.string   "from_state"
    t.string   "sms_status"
    t.string   "from_city"
    t.text     "body"
    t.string   "from_country"
    t.string   "to"
    t.string   "to_zip"
    t.string   "message_sid"
    t.string   "from"
    t.string   "api_version"
    t.integer  "day_of_flight_id"
    t.integer  "person_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "account_sid"
    t.string   "error_url"
    t.string   "controller"
    t.string   "action"
    t.string   "error_code"
  end

  add_index "sms_messages", ["day_of_flight_id"], name: "index_sms_messages_on_day_of_flight_id", using: :btree
  add_index "sms_messages", ["person_id"], name: "index_sms_messages_on_person_id", using: :btree

  create_table "smtp_settings", force: :cascade do |t|
    t.boolean  "send_mail"
    t.string   "host"
    t.string   "smtp_server"
    t.integer  "port"
    t.string   "authentication"
    t.string   "username"
    t.string   "password"
    t.boolean  "enable_starttls_auto"
    t.string   "openssl_verify_mode"
    t.string   "from_name"
    t.string   "default_url_options"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "volunteers_roles", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "volunteers_roles", ["person_id"], name: "index_volunteers_roles_on_person_id", using: :btree
  add_index "volunteers_roles", ["role_id"], name: "index_volunteers_roles_on_role_id", using: :btree

  create_table "wars", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "begin_year"
    t.date     "end_year"
  end

  add_foreign_key "addresses", "people"
  add_foreign_key "awards", "branches"
  add_foreign_key "contacts", "addresses"
  add_foreign_key "contacts", "contact_categories"
  add_foreign_key "contacts", "contact_relationships"
  add_foreign_key "contacts", "people"
  add_foreign_key "day_of_flights", "wars"
  add_foreign_key "day_of_flights_volunteers", "day_of_flights"
  add_foreign_key "day_of_flights_volunteers", "flight_responsibilities"
  add_foreign_key "day_of_flights_volunteers", "people"
  add_foreign_key "flight_attachments", "day_of_flights"
  add_foreign_key "flight_details", "airlines"
  add_foreign_key "flight_details", "day_of_flights"
  add_foreign_key "flight_responsibilities", "roles"
  add_foreign_key "medical_allergies", "people"
  add_foreign_key "medical_condition_names", "medical_condition_types"
  add_foreign_key "medical_conditions", "medical_condition_names"
  add_foreign_key "medical_conditions", "medical_condition_types"
  add_foreign_key "medical_conditions", "people"
  add_foreign_key "medications", "medication_routes"
  add_foreign_key "medications", "people"
  add_foreign_key "people", "day_of_flights"
  add_foreign_key "people", "mobility_devices"
  add_foreign_key "people", "name_suffixes"
  add_foreign_key "people", "person_statuses"
  add_foreign_key "people", "shirt_sizes"
  add_foreign_key "people", "wars"
  add_foreign_key "people_attachments", "people"
  add_foreign_key "ranks", "rank_types"
  add_foreign_key "service_awards", "awards"
  add_foreign_key "service_awards", "service_histories"
  add_foreign_key "service_histories", "branches"
  add_foreign_key "service_histories", "people"
  add_foreign_key "service_histories", "rank_types"
  add_foreign_key "service_histories", "ranks"
  add_foreign_key "sms_messages", "day_of_flights"
  add_foreign_key "sms_messages", "people"
  add_foreign_key "volunteers_roles", "people"
  add_foreign_key "volunteers_roles", "roles"
end
