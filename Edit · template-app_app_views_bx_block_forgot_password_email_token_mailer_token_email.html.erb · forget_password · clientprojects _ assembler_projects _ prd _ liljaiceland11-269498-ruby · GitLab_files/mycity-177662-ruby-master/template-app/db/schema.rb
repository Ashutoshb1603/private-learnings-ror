# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 202203041419071) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_qualifications", force: :cascade do |t|
    t.string "school"
    t.string "location"
    t.string "academic_board"
    t.string "course_name"
    t.string "start_year"
    t.string "end_year"
    t.string "grade"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "degree"
    t.string "specialization"
    t.string "institute"
    t.index ["account_id"], name: "index_academic_qualifications_on_account_id"
  end

  create_table "account_categories", force: :cascade do |t|
    t.integer "account_id"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_details_wallets", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.float "available_balance", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_details_wallets_on_account_id"
  end

  create_table "account_event_blocks", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_event_blocks_on_account_id"
    t.index ["event_block_id"], name: "index_account_event_blocks_on_event_block_id"
  end

  create_table "account_jobs", force: :cascade do |t|
    t.string "type"
    t.integer "account_id"
    t.integer "job_id"
    t.string "job_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_profiles", force: :cascade do |t|
    t.string "name"
    t.string "profession"
    t.string "gender"
    t.string "full_address"
    t.string "bio"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "email"
    t.text "profile_summary"
    t.index ["account_id"], name: "index_account_profiles_on_account_id"
  end

  create_table "account_social_clubs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "social_club_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_social_clubs_on_account_id"
    t.index ["social_club_id"], name: "index_account_social_clubs_on_social_club_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_phone_number"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "email"
    t.boolean "activated", default: false, null: false
    t.string "device_id"
    t.text "unique_auth_id"
    t.string "password_digest"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id"
    t.string "user_name"
    t.string "platform"
    t.string "user_type"
    t.integer "app_language_id"
    t.datetime "last_visit_at"
    t.boolean "is_blacklisted", default: false
    t.date "suspend_until"
    t.integer "status", default: 0, null: false
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.datetime "stripe_subscription_date"
    t.string "full_name"
    t.integer "gender"
    t.date "date_of_birth"
    t.integer "age"
    t.boolean "is_paid", default: false
    t.string "language"
    t.boolean "service_and_policy"
    t.boolean "term_and_condition"
    t.boolean "age_confirmation"
    t.text "interests"
    t.string "currency"
    t.float "latitude"
    t.float "longitude"
    t.string "current_city"
    t.string "preferred_language"
  end

  create_table "accounts_chats", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false
    t.string "participant_sid"
    t.index ["account_id"], name: "index_accounts_chats_on_account_id"
    t.index ["chat_id"], name: "index_accounts_chats_on_chat_id"
  end

  create_table "accounts_interests", force: :cascade do |t|
    t.integer "account_id"
    t.integer "interest_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "achievements", force: :cascade do |t|
    t.string "title"
    t.date "achievement_date"
    t.text "detail"
    t.string "url"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.boolean "default_image", default: false
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
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.string "name_ar"
    t.integer "account_id"
  end

  create_table "activities_club_events", id: false, force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "club_event_id", null: false
  end

  create_table "activities_hidden_places", id: false, force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "activity_id", null: false
    t.index ["activity_id", "hidden_place_id"], name: "idx_activities_places"
    t.index ["hidden_place_id", "activity_id"], name: "idx_place_activities"
  end

  create_table "additional_infos", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "religion"
    t.string "caste"
    t.string "birth_place"
    t.string "house_type"
    t.boolean "available_as_freelancer"
    t.integer "rate_per_hour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "living_in"
    t.string "living_with"
    t.index ["account_id"], name: "index_additional_infos_on_account_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "addressble_id"
    t.string "addressble_type"
    t.integer "address_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "applicant_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_applicant_comments_on_account_id"
  end

  create_table "applicant_statuses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_applicant_statuses_on_account_id"
  end

  create_table "associated_projects", force: :cascade do |t|
    t.integer "project_id"
    t.integer "associated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "associateds", force: :cascade do |t|
    t.string "associated_with_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "service_provider_id"
    t.string "start_time"
    t.string "end_time"
    t.string "unavailable_start_time"
    t.string "unavailable_end_time"
    t.string "availability_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "timeslots"
    t.integer "available_slots_count"
    t.index ["service_provider_id"], name: "index_availabilities_on_service_provider_id"
  end

  create_table "awards", force: :cascade do |t|
    t.string "title"
    t.string "associated_with"
    t.string "issuer"
    t.datetime "issue_date"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "black_list_users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_black_list_users_on_account_id"
  end

  create_table "bx_block_appointment_management_booked_slots", force: :cascade do |t|
    t.bigint "order_id"
    t.string "start_time"
    t.string "end_time"
    t.bigint "service_provider_id"
    t.date "booking_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "career_experience_employment_types", force: :cascade do |t|
    t.integer "career_experience_id"
    t.integer "employment_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "career_experience_industry", force: :cascade do |t|
    t.integer "career_experience_id"
    t.integer "industry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "career_experience_system_experiences", force: :cascade do |t|
    t.integer "career_experience_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "system_experience_id"
  end

  create_table "career_experiences", force: :cascade do |t|
    t.string "job_title"
    t.date "start_date"
    t.date "end_date"
    t.string "company_name"
    t.text "description"
    t.string "add_key_achievements", default: [], array: true
    t.boolean "make_key_achievements_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "current_salary", default: "0.0"
    t.text "notice_period"
    t.date "notice_period_end_date"
    t.boolean "currently_working_here", default: false
  end

  create_table "careers", force: :cascade do |t|
    t.string "profession"
    t.boolean "is_current", default: false
    t.string "experience_from"
    t.string "experience_to"
    t.string "payscale"
    t.string "company_name"
    t.string "accomplishment", array: true
    t.integer "sector"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_user_id"
    t.integer "rank"
    t.string "light_icon"
    t.string "light_icon_active"
    t.string "light_icon_inactive"
    t.string "dark_icon"
    t.string "dark_icon_active"
    t.string "dark_icon_inactive"
    t.integer "identifier"
  end

  create_table "categories_sub_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sub_category_id", null: false
    t.index ["category_id"], name: "index_categories_sub_categories_on_category_id"
    t.index ["sub_category_id"], name: "index_categories_sub_categories_on_sub_category_id"
  end

  create_table "certifications", force: :cascade do |t|
    t.string "name"
    t.string "organization_name"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["account_id"], name: "index_certifications_on_account_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id"
    t.string "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_mark_read", default: false
    t.integer "message_type"
    t.string "attachment"
    t.index ["account_id"], name: "index_chat_messages_on_account_id"
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "chat_type", null: false
    t.string "name", default: "", null: false
    t.string "conversation_sid"
    t.string "group_image"
    t.bigint "social_club_id"
    t.index ["social_club_id"], name: "index_chats_on_social_club_id"
  end

  create_table "club_event_accounts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "club_event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "unique_code"
    t.index ["account_id"], name: "index_club_event_accounts_on_account_id"
    t.index ["club_event_id"], name: "index_club_event_accounts_on_club_event_id"
  end

  create_table "club_events", force: :cascade do |t|
    t.integer "social_club_id"
    t.string "event_name"
    t.string "location"
    t.boolean "is_visible", default: false
    t.datetime "start_date_and_time"
    t.datetime "end_date_and_time"
    t.integer "max_participants"
    t.integer "min_participants"
    t.string "fee_currency"
    t.decimal "fee_amount_cents", precision: 8, scale: 2
    t.text "description"
    t.integer "age_should_be"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "city"
  end

  create_table "club_events_equipments", id: false, force: :cascade do |t|
    t.bigint "equipment_id", null: false
    t.bigint "club_event_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "commentable_id"
    t.string "commentable_type"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "industry"
    t.string "company_type"
    t.string "headquarters"
    t.integer "no_of_employees"
    t.string "type_of_company"
    t.string "tagline"
    t.string "public_link"
    t.text "about_the_company"
    t.boolean "approved", default: false
    t.string "established_in"
    t.string "services", default: [], array: true
    t.string "email"
    t.string "ceo_of_company"
  end

  create_table "company_cultures", force: :cascade do |t|
    t.string "culture_names", default: [], array: true
    t.string "employee_benefits", default: [], array: true
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_cultures_on_company_id"
  end

  create_table "company_users", force: :cascade do |t|
    t.string "role"
    t.bigint "company_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_company_users_on_account_id"
    t.index ["company_id"], name: "index_company_users_on_company_id"
  end

  create_table "contact_details", force: :cascade do |t|
    t.string "phone_number"
    t.string "email"
    t.text "address"
    t.string "city"
    t.string "state"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_contact_details_on_company_id"
  end

  create_table "contact_us", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.string "duration"
    t.string "year"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cta", force: :cascade do |t|
    t.string "headline"
    t.text "description"
    t.bigint "category_id"
    t.string "long_background_image"
    t.string "square_background_image"
    t.string "button_text"
    t.string "redirect_url"
    t.integer "text_alignment"
    t.integer "button_alignment"
    t.boolean "is_square_cta"
    t.boolean "is_long_rectangle_cta"
    t.boolean "is_text_cta"
    t.boolean "is_image_cta"
    t.boolean "has_button"
    t.boolean "visible_on_home_page"
    t.boolean "visible_on_details_page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_cta_on_category_id"
  end

  create_table "current_annual_salaries", force: :cascade do |t|
    t.string "current_annual_salary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_annual_salary_current_status", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "current_annual_salary_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status", force: :cascade do |t|
    t.string "most_recent_job_title"
    t.string "company_name"
    t.text "notice_period"
    t.date "end_date"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status_employment_types", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "employment_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status_industries", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "industry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "degree_educational_qualifications", force: :cascade do |t|
    t.integer "educational_qualification_id"
    t.integer "degree_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string "degree_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "token"
    t.string "platform"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_devices_on_account_id"
  end

  create_table "educational_qualification_field_study", force: :cascade do |t|
    t.integer "educational_qualification_id"
    t.integer "field_study_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educational_qualifications", force: :cascade do |t|
    t.string "school_name"
    t.date "start_date"
    t.date "end_date"
    t.string "grades"
    t.text "description"
    t.boolean "make_grades_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string "qualification"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year_from"
    t.string "year_to"
    t.text "description"
  end

  create_table "email_otps", force: :cascade do |t|
    t.string "email"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employment_types", force: :cascade do |t|
    t.string "employment_type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "endorses", force: :cascade do |t|
    t.string "endorse_type"
    t.string "name"
    t.bigint "account_id", null: false
    t.bigint "company_culture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_endorses_on_account_id"
    t.index ["company_culture_id"], name: "index_endorses_on_company_culture_id"
  end

  create_table "equipments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_blocks", force: :cascade do |t|
    t.string "event_name"
    t.string "location"
    t.datetime "start_date_and_time"
    t.datetime "end_date_and_time"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_travel_items", force: :cascade do |t|
    t.bigint "travel_item_id", null: false
    t.bigint "club_event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["club_event_id"], name: "index_event_travel_items_on_club_event_id"
    t.index ["travel_item_id"], name: "index_event_travel_items_on_travel_item_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.time "time"
    t.date "date"
    t.string "latitude"
    t.string "longitude"
    t.string "assign_to", default: [], array: true
    t.bigint "email_account_id"
    t.integer "notify"
    t.integer "repeat"
    t.text "notes"
    t.string "visibility", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "event_type"
    t.text "address"
    t.string "assignee_email", default: [], array: true
    t.string "visible_email", default: [], array: true
    t.integer "custom_repeat_in_number"
    t.integer "custom_repeat_every"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "company_name"
    t.string "location"
    t.string "position"
    t.string "job_type"
    t.date "joining_date"
    t.date "leaving_date"
    t.string "bio"
    t.boolean "currently_working"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "responsibilities"
    t.index ["account_id"], name: "index_experiences_on_account_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "favouriteable_id"
    t.string "favouriteable_type"
    t.integer "user_id"
  end

  create_table "field_study", force: :cascade do |t|
    t.string "field_of_study"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flagged_message_accounts", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "flagged_message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_flagged_message_accounts_on_account_id"
    t.index ["flagged_message_id"], name: "index_flagged_message_accounts_on_flagged_message_id"
  end

  create_table "flagged_messages", force: :cascade do |t|
    t.string "conversation_sid"
    t.string "message_sid"
    t.integer "flag_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "followships", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_followships_on_account_id"
    t.index ["company_id"], name: "index_followships_on_company_id"
  end

  create_table "global_settings", force: :cascade do |t|
    t.string "notice_period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "google_place_integrations", force: :cascade do |t|
    t.string "city"
    t.string "latitude"
    t.string "longitude"
    t.text "page_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city"], name: "index_google_place_integrations_on_city"
    t.index ["latitude", "longitude"], name: "index_google_place_integrations_on_latitude_and_longitude"
  end

  create_table "hidden_place_activities", force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_id"], name: "index_hidden_place_activities_on_activity_id"
    t.index ["hidden_place_id"], name: "index_hidden_place_activities_on_hidden_place_id"
  end

  create_table "hidden_place_travel_items", force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "travel_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hidden_place_id"], name: "index_hidden_place_travel_items_on_hidden_place_id"
    t.index ["travel_item_id"], name: "index_hidden_place_travel_items_on_travel_item_id"
  end

  create_table "hidden_place_weathers", force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "weather_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hidden_place_id"], name: "index_hidden_place_weathers_on_hidden_place_id"
    t.index ["weather_id"], name: "index_hidden_place_weathers_on_weather_id"
  end

  create_table "hidden_places", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "place_name"
    t.string "google_map_link"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.index ["account_id"], name: "index_hidden_places_on_account_id"
    t.index ["latitude", "longitude"], name: "index_hidden_places_on_latitude_and_longitude"
  end

  create_table "hidden_places_travel_items", id: false, force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "travel_item_id", null: false
    t.index ["hidden_place_id", "travel_item_id"], name: "idx_place_travel_items"
    t.index ["travel_item_id", "hidden_place_id"], name: "idx_travel_items_place"
  end

  create_table "hidden_places_weathers", id: false, force: :cascade do |t|
    t.bigint "hidden_place_id", null: false
    t.bigint "weather_id", null: false
    t.index ["hidden_place_id", "weather_id"], name: "idx_place_weather"
    t.index ["weather_id", "hidden_place_id"], name: "idx_weather_places"
  end

  create_table "hobbies_and_interests", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "industry_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_ar"
    t.integer "created_by"
  end

  create_table "interests_social_clubs", id: false, force: :cascade do |t|
    t.bigint "interest_id", null: false
    t.bigint "social_club_id", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "language"
    t.string "proficiency"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "like_by_id"
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "van_id"
    t.text "address"
    t.string "locationable_type", null: false
    t.bigint "locationable_id", null: false
    t.index ["locationable_type", "locationable_id"], name: "index_locations_on_locationable_type_and_locationable_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "created_by"
    t.string "headings"
    t.string "contents"
    t.string "app_url"
    t.boolean "is_read", default: false
    t.datetime "read_at"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["account_id"], name: "index_notifications_on_account_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "card_token"
    t.boolean "is_primary", default: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_payment_methods_on_account_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "ammount"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.text "location"
    t.string "language"
    t.string "status"
    t.string "club_type"
    t.text "google_place_url"
    t.string "city"
    t.index ["club_type"], name: "index_pg_search_documents_on_club_type"
    t.index ["language"], name: "index_pg_search_documents_on_language"
    t.index ["latitude", "longitude"], name: "index_pg_search_documents_on_latitude_and_longitude"
    t.index ["name"], name: "index_pg_search_documents_on_name"
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
    t.index ["status"], name: "index_pg_search_documents_on_status"
  end

  create_table "posts", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "body"
    t.string "location"
    t.integer "account_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "seeking"
    t.string "discover_people", array: true
    t.text "location"
    t.integer "distance"
    t.integer "height_type"
    t.integer "body_type"
    t.integer "religion"
    t.integer "smoking"
    t.integer "drinking"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "friend", default: false
    t.boolean "business", default: false
    t.boolean "match_making", default: false
    t.boolean "travel_partner", default: false
    t.boolean "cross_path", default: false
    t.integer "age_range_start"
    t.integer "age_range_end"
    t.string "height_range_start"
    t.string "height_range_end"
    t.integer "account_id"
  end

  create_table "preferred_jobs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "job_name"
    t.string "skills"
    t.string "location"
    t.string "job_type"
    t.string "notice_period"
    t.string "visa_type"
    t.boolean "is_foreign_visa_available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "rate_per_hour"
    t.boolean "available_as_freelancer"
    t.index ["account_id"], name: "index_preferred_jobs_on_account_id"
  end

  create_table "profile_bios", force: :cascade do |t|
    t.integer "account_id"
    t.string "height"
    t.string "weight"
    t.integer "height_type"
    t.integer "weight_type"
    t.integer "body_type"
    t.integer "mother_tougue"
    t.integer "religion"
    t.integer "zodiac"
    t.integer "marital_status"
    t.string "languages", array: true
    t.text "about_me"
    t.string "personality", array: true
    t.string "interests", array: true
    t.integer "smoking"
    t.integer "drinking"
    t.integer "looking_for"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "about_business"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "country"
    t.string "address"
    t.string "postal_code"
    t.integer "account_id"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_role"
    t.string "city"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.date "start_date"
    t.date "end_date"
    t.string "add_members"
    t.string "url"
    t.text "description"
    t.boolean "make_projects_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "publication_patents", force: :cascade do |t|
    t.string "title"
    t.string "publication"
    t.string "authors"
    t.string "url"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "push_notifications", force: :cascade do |t|
    t.bigint "account_id"
    t.string "push_notificable_type", null: false
    t.bigint "push_notificable_id", null: false
    t.string "remarks"
    t.boolean "is_read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "notify_type"
    t.string "content"
    t.string "image"
    t.index ["account_id"], name: "index_push_notifications_on_account_id"
    t.index ["push_notificable_type", "push_notificable_id"], name: "index_push_notification_type_and_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "account_id"
    t.integer "sender_id"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "rating"
    t.bigint "account_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_reviews_on_account_id"
    t.index ["company_id"], name: "index_reviews_on_company_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "search_histories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "history_type"
    t.index ["account_id"], name: "index_search_histories_on_account_id"
    t.index ["content"], name: "index_search_histories_on_content"
  end

  create_table "skill_sets", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_skill_sets_on_account_id"
  end

  create_table "sms_otps", force: :cascade do |t|
    t.string "full_phone_number"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "social_clubs", force: :cascade do |t|
    t.integer "account_id"
    t.text "description"
    t.text "community_rules"
    t.string "location"
    t.boolean "is_visible", default: false
    t.integer "chat_channels", default: [], array: true
    t.integer "user_capacity"
    t.string "bank_name"
    t.string "bank_account_name"
    t.string "bank_account_number"
    t.string "routing_code"
    t.integer "max_channel_count"
    t.integer "status", default: 0
    t.string "fee_currency"
    t.decimal "fee_amount_cents", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.integer "language"
    t.string "latitude"
    t.string "longitude"
    t.string "city"
  end

  create_table "street_jobs", force: :cascade do |t|
    t.string "company_name"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "type_of_employer"
    t.string "role"
    t.string "job_type"
    t.string "salary_range"
    t.text "job_description"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "expires_in"
    t.index ["account_id"], name: "index_street_jobs_on_account_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.integer "rank"
  end

  create_table "system_experiences", force: :cascade do |t|
    t.string "system_experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "terms_and_conditions", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description_ar"
  end

  create_table "test_score_and_courses", force: :cascade do |t|
    t.string "title"
    t.string "associated_with"
    t.string "score"
    t.datetime "test_date"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.string "transaction_entity_type"
    t.string "transaction_entity_name"
    t.float "amount"
    t.string "transaction_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "transaction_type"
    t.index ["wallet_id"], name: "index_transaction_histories_on_wallet_id"
  end

  create_table "transfer_requests", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.float "amount"
    t.bigint "wallet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["wallet_id"], name: "index_transfer_requests_on_wallet_id"
  end

  create_table "travel_items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_ar"
    t.integer "account_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_categories_on_account_id"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
  end

  create_table "user_sub_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "sub_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_sub_categories_on_account_id"
    t.index ["sub_category_id"], name: "index_user_sub_categories_on_sub_category_id"
  end

  create_table "van_members", force: :cascade do |t|
    t.integer "account_id"
    t.integer "van_id"
  end

  create_table "vans", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.boolean "is_offline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "view_profiles", force: :cascade do |t|
    t.integer "profile_bio_id"
    t.integer "view_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "account_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "available_balance", default: 0.0
    t.index ["account_id"], name: "index_wallets_on_account_id"
  end

  create_table "weathers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_ar"
    t.integer "account_id"
  end

  add_foreign_key "academic_qualifications", "accounts"
  add_foreign_key "account_details_wallets", "accounts"
  add_foreign_key "account_event_blocks", "accounts"
  add_foreign_key "account_event_blocks", "event_blocks"
  add_foreign_key "account_profiles", "accounts"
  add_foreign_key "account_social_clubs", "accounts"
  add_foreign_key "account_social_clubs", "social_clubs"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "additional_infos", "accounts"
  add_foreign_key "applicant_comments", "accounts"
  add_foreign_key "applicant_statuses", "accounts"
  add_foreign_key "black_list_users", "accounts"
  add_foreign_key "categories_sub_categories", "categories"
  add_foreign_key "categories_sub_categories", "sub_categories"
  add_foreign_key "certifications", "accounts"
  add_foreign_key "chat_messages", "accounts"
  add_foreign_key "chat_messages", "chats"
  add_foreign_key "club_event_accounts", "accounts"
  add_foreign_key "club_event_accounts", "club_events"
  add_foreign_key "comments", "accounts"
  add_foreign_key "company_cultures", "companies"
  add_foreign_key "contact_details", "companies"
  add_foreign_key "devices", "accounts"
  add_foreign_key "endorses", "accounts"
  add_foreign_key "endorses", "company_cultures"
  add_foreign_key "event_travel_items", "club_events"
  add_foreign_key "event_travel_items", "travel_items"
  add_foreign_key "experiences", "accounts"
  add_foreign_key "followships", "accounts"
  add_foreign_key "followships", "companies"
  add_foreign_key "hidden_place_activities", "activities"
  add_foreign_key "hidden_place_activities", "hidden_places"
  add_foreign_key "hidden_place_travel_items", "hidden_places"
  add_foreign_key "hidden_place_travel_items", "travel_items"
  add_foreign_key "hidden_place_weathers", "hidden_places"
  add_foreign_key "hidden_place_weathers", "weathers"
  add_foreign_key "hidden_places", "accounts"
  add_foreign_key "notifications", "accounts"
  add_foreign_key "payment_methods", "accounts"
  add_foreign_key "payments", "accounts"
  add_foreign_key "posts", "categories"
  add_foreign_key "preferred_jobs", "accounts"
  add_foreign_key "push_notifications", "accounts"
  add_foreign_key "reviews", "accounts"
  add_foreign_key "reviews", "companies"
  add_foreign_key "skill_sets", "accounts"
  add_foreign_key "street_jobs", "accounts"
  add_foreign_key "transaction_histories", "wallets"
  add_foreign_key "transfer_requests", "wallets"
  add_foreign_key "user_categories", "accounts"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_sub_categories", "accounts"
  add_foreign_key "user_sub_categories", "sub_categories"
  add_foreign_key "wallets", "accounts"
end
