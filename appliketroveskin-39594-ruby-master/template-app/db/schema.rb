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

ActiveRecord::Schema.define(version: 2021_10_25_223759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "academy_videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.integer "academy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_choice_skin_logs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "skin_quiz_id", null: false
    t.bigint "choice_ids", array: true
    t.string "other"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_choice_skin_logs_on_account_id"
    t.index ["skin_quiz_id"], name: "index_account_choice_skin_logs_on_skin_quiz_id"
  end

  create_table "account_choice_skin_quizzes", force: :cascade do |t|
    t.bigint "skin_quiz_id", null: false
    t.bigint "account_id", null: false
    t.bigint "choice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_choice_skin_quizzes_on_account_id"
    t.index ["choice_id"], name: "index_account_choice_skin_quizzes_on_choice_id"
    t.index ["skin_quiz_id"], name: "index_skin_quiz_on_skin_quiz_user_choice"
  end

  create_table "accounts", force: :cascade do |t|
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
    t.string "first_name"
    t.boolean "is_deleted", default: false
    t.string "gender"
    t.boolean "is_subscribed_to_mailing", default: false
    t.integer "sign_in_count", default: 0
    t.string "jwt_token"
    t.text "device_token"
    t.string "device"
    t.string "stripe_customer_id"
    t.string "acuity_calendar"
    t.string "last_name"
    t.boolean "freeze_account", default: false
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
    t.integer "accountable_id"
    t.integer "action"
    t.string "objectable_type"
    t.bigint "objectable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "concern_mail_id"
    t.string "accountable_type"
    t.index ["objectable_type", "objectable_id"], name: "index_activities_on_objectable_type_and_objectable_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.integer "address_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.string "street1"
    t.string "street2"
    t.string "postcode"
    t.string "address"
    t.string "city"
    t.string "province"
    t.string "shopify_address_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id"
    t.string "name"
    t.string "jwt_token"
    t.boolean "freeze_account", default: false
    t.string "device_token"
    t.string "device"
    t.integer "sign_in_count", default: 0
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "advertisements", force: :cascade do |t|
    t.string "url"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "dimension"
    t.integer "click_count", default: 0
    t.string "product_id"
    t.string "country", default: "Ireland"
  end

  create_table "automatic_renewals", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "subscription_type"
    t.boolean "is_auto_renewal", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_automatic_renewals_on_account_id"
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

  create_table "bad_wordsets", force: :cascade do |t|
    t.text "words"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blog_views", force: :cascade do |t|
    t.string "blog_id"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "cart_items", force: :cascade do |t|
    t.string "variant_id"
    t.integer "quantity"
    t.integer "account_id"
    t.string "name"
    t.decimal "price"
    t.string "product_id"
    t.string "product_image_url"
    t.decimal "total_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variant_colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variant_sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variants", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "catalogue_variant_color_id"
    t.bigint "catalogue_variant_size_id"
    t.decimal "price"
    t.integer "stock_qty"
    t.boolean "on_sale"
    t.decimal "sale_price"
    t.decimal "discount_price"
    t.float "length"
    t.float "breadth"
    t.float "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "block_qty"
    t.index ["catalogue_id"], name: "index_catalogue_variants_on_catalogue_id"
    t.index ["catalogue_variant_color_id"], name: "index_catalogue_variants_on_catalogue_variant_color_id"
    t.index ["catalogue_variant_size_id"], name: "index_catalogue_variants_on_catalogue_variant_size_id"
  end

  create_table "catalogues", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sub_category_id", null: false
    t.bigint "brand_id"
    t.string "name"
    t.string "sku"
    t.string "description"
    t.datetime "manufacture_date"
    t.float "length"
    t.float "breadth"
    t.float "height"
    t.integer "availability"
    t.integer "stock_qty"
    t.decimal "weight"
    t.float "price"
    t.boolean "recommended"
    t.boolean "on_sale"
    t.decimal "sale_price"
    t.decimal "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "block_qty"
    t.index ["brand_id"], name: "index_catalogues_on_brand_id"
    t.index ["category_id"], name: "index_catalogues_on_category_id"
    t.index ["sub_category_id"], name: "index_catalogues_on_sub_category_id"
  end

  create_table "catalogues_tags", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "tag_id", null: false
    t.index ["catalogue_id"], name: "index_catalogues_tags_on_catalogue_id"
    t.index ["tag_id"], name: "index_catalogues_tags_on_tag_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_sub_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sub_category_id", null: false
    t.index ["category_id"], name: "index_categories_sub_categories_on_category_id"
    t.index ["sub_category_id"], name: "index_categories_sub_categories_on_sub_category_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "account_id"
    t.integer "status", default: 1
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "therapist_id"
    t.boolean "pinned", default: false
    t.string "sid"
  end

  create_table "choice_tags", force: :cascade do |t|
    t.bigint "choice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag_id"
    t.index ["choice_id"], name: "index_choice_tags_on_choice_id"
  end

  create_table "choices", force: :cascade do |t|
    t.text "choice"
    t.integer "skin_quiz_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
  end

  create_table "combo_offers", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.integer "discount_percentage"
    t.string "sub_title"
    t.datetime "offer_end_date"
    t.datetime "offer_start_date"
    t.float "final_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "description"
    t.string "objectable_type"
    t.bigint "objectable_id"
    t.integer "accountable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "offensive", default: false
    t.string "accountable_type"
    t.index ["objectable_type", "objectable_id"], name: "index_comments_on_objectable_type_and_objectable_id"
  end

  create_table "consultation_types", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupon_services", force: :cascade do |t|
    t.integer "sub_categories_id"
    t.integer "coupon_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "name"
    t.integer "discount"
    t.integer "coupon_type"
    t.float "min_order"
    t.integer "status"
    t.float "max_discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customer_academy_subscriptions", force: :cascade do |t|
    t.integer "account_id"
    t.integer "academy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customer_favourite_products", force: :cascade do |t|
    t.integer "account_id"
    t.string "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discount_code_usages", force: :cascade do |t|
    t.string "discount_code"
    t.integer "value_type", default: 1
    t.integer "amount"
    t.integer "account_id"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dynamic_images", force: :cascade do |t|
    t.integer "image_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "email_otps", force: :cascade do |t|
    t.string "email"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "explanation_texts", force: :cascade do |t|
    t.string "section_name"
    t.text "value"
    t.string "area_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "featured_posts", force: :cascade do |t|
    t.string "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "frame_images", force: :cascade do |t|
    t.string "user_type"
    t.bigint "life_event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["life_event_id"], name: "index_frame_images_on_life_event_id"
  end

  create_table "gift_types", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hero_products", force: :cascade do |t|
    t.integer "tags_type", default: 1
    t.string "title", default: ""
    t.text "tags", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "info_texts", force: :cascade do |t|
    t.string "description", default: ""
    t.integer "screen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "key_points", force: :cascade do |t|
    t.string "description"
    t.integer "academy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "life_events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "info_text", default: ""
  end

  create_table "likes", force: :cascade do |t|
    t.integer "accountable_id"
    t.string "objectable_type", null: false
    t.bigint "objectable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "accountable_type"
    t.index ["objectable_type", "objectable_id"], name: "index_likes_on_objectable_type_and_objectable_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.string "variant_id"
    t.integer "quantity"
    t.integer "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "total_discount", precision: 10, scale: 2
    t.string "product_id"
    t.string "product_image_url"
  end

  create_table "live_videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 2
    t.string "room_sid"
    t.string "composition_sid"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "van_id"
  end

  create_table "membership_plans", force: :cascade do |t|
    t.integer "plan_type"
    t.datetime "start_date", default: "2021-06-08 05:37:56"
    t.datetime "end_date", default: "2021-06-08 05:37:56"
    t.integer "time_period"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "message_objects", force: :cascade do |t|
    t.string "object_id"
    t.string "object_type"
    t.string "title"
    t.decimal "price", precision: 10, scale: 2
    t.string "variant_id"
    t.string "image_url"
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_message_objects_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "chat_id"
    t.integer "account_id"
    t.text "message"
    t.boolean "is_read", default: false
    t.string "objectable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notification_periods", force: :cascade do |t|
    t.string "notification_type"
    t.string "period_type"
    t.integer "period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "created_by"
    t.string "headings"
    t.text "contents"
    t.string "app_url"
    t.boolean "is_read", default: false
    t.datetime "read_at"
    t.bigint "accountable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "room_name"
    t.integer "notification_type", default: 1
    t.integer "user_type", default: 1
    t.string "sid"
    t.string "type_by_user"
    t.string "accountable_type"
    t.string "redirect"
    t.index ["accountable_id"], name: "index_notifications_on_accountable_id"
  end

  create_table "offer_services", force: :cascade do |t|
    t.bigint "combo_offer_id"
    t.bigint "sub_category_id"
  end

  create_table "order_combo_offers", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "combo_offer_id"
  end

  create_table "order_services", force: :cascade do |t|
    t.bigint "shopping_cart_order_id", null: false
    t.bigint "sub_category_id"
    t.index ["shopping_cart_order_id"], name: "index_order_services_on_shopping_cart_order_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "account_id"
    t.integer "status"
    t.string "token"
    t.string "charge_id"
    t.string "error_message"
    t.string "customer_id"
    t.integer "payment_gateway"
    t.integer "price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "can"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plans", force: :cascade do |t|
    t.decimal "price_cents"
    t.string "name"
    t.string "stripe_plan_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "interval"
  end

  create_table "product_videos", force: :cascade do |t|
    t.string "product_id"
    t.string "video_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_tags", force: :cascade do |t|
    t.integer "group_id"
    t.integer "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "status", default: 1
    t.integer "accountable_id"
    t.boolean "anonymous", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "offensive", default: false
    t.integer "user_type", default: 1
    t.string "accountable_type"
  end

  create_table "recent_searches", force: :cascade do |t|
    t.string "search_param"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "refferal_coupons", force: :cascade do |t|
    t.string "coupon"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.string "comment"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_reviews_on_catalogue_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "saved", force: :cascade do |t|
    t.integer "accountable_id"
    t.integer "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "accountable_type"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.bigint "service_provider_id"
    t.bigint "customer_id"
    t.integer "address_id"
    t.date "booking_date"
    t.string "slot_start_time"
    t.float "total_fees"
    t.text "instructions"
    t.string "service_total_time_minutes"
    t.string "status"
    t.float "discount"
    t.integer "coupon_id"
    t.boolean "is_coupon_applied"
    t.integer "order_type"
    t.boolean "notify_me"
    t.boolean "job_status", default: false
    t.string "ongoing_time"
    t.string "finish_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "phone"
    t.integer "financial_status", default: 1
    t.string "order_id"
    t.text "cancel_reason"
    t.date "cancelled_at"
    t.decimal "subtotal_price", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2
    t.decimal "total_tax"
    t.decimal "shipping_charges"
    t.string "tax_title"
    t.string "shipping_title"
    t.boolean "requires_shipping", default: true
    t.integer "shipping_id"
    t.string "transaction_id"
    t.index ["customer_id"], name: "index_shopping_cart_orders_on_customer_id"
    t.index ["service_provider_id"], name: "index_shopping_cart_orders_on_service_provider_id"
  end

  create_table "skin_clinic_availabilities", force: :cascade do |t|
    t.bigint "skin_clinic_id", null: false
    t.string "day"
    t.time "from"
    t.time "to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skin_clinic_id"], name: "index_skin_clinic_availabilities_on_skin_clinic_id"
  end

  create_table "skin_clinics", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.decimal "longitude"
    t.decimal "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.string "clinic_link"
  end

  create_table "skin_hub_likes", force: :cascade do |t|
    t.integer "account_id"
    t.integer "objectable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "objectable_type"
  end

  create_table "skin_hub_views", force: :cascade do |t|
    t.integer "account_id"
    t.integer "objectable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "objectable_type"
  end

  create_table "skin_quizzes", force: :cascade do |t|
    t.text "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "seq_no"
    t.boolean "active", default: true
    t.string "question_type", default: "sign_up"
    t.boolean "allows_multiple", default: false
    t.string "info_text", default: ""
    t.string "short_text", default: ""
    t.string "acuity_field_id", default: ""
  end

  create_table "skincare_products", force: :cascade do |t|
    t.string "name"
    t.string "product_id"
    t.integer "skincare_step_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image_url"
  end

  create_table "skincare_routines", force: :cascade do |t|
    t.integer "therapist_id"
    t.integer "account_id"
    t.integer "routine_type"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "skincare_steps", force: :cascade do |t|
    t.text "step"
    t.integer "skincare_routine_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "header"
  end

  create_table "sms_otps", force: :cascade do |t|
    t.string "full_phone_number"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "objectable_type"
    t.bigint "objectable_id"
    t.integer "target"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["objectable_type", "objectable_id"], name: "index_stories_on_objectable_type_and_objectable_id"
  end

  create_table "story_views", force: :cascade do |t|
    t.integer "accountable_id"
    t.integer "story_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "accountable_type"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "therapist_notes", force: :cascade do |t|
    t.integer "therapist_id"
    t.integer "account_id"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tutorials", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_consultations", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.integer "age"
    t.string "email"
    t.bigint "account_id", null: false
    t.integer "therapist_id"
    t.datetime "booked_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_consultations_on_account_id"
  end

  create_table "user_events", force: :cascade do |t|
    t.bigint "life_event_id", null: false
    t.bigint "account_id", null: false
    t.date "event_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "show_frame_till"
    t.index ["account_id"], name: "index_user_events_on_account_id"
    t.index ["life_event_id"], name: "index_user_events_on_life_event_id"
  end

  create_table "user_images", force: :cascade do |t|
    t.string "position"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_images_on_account_id"
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

  create_table "views", force: :cascade do |t|
    t.integer "accountable_id"
    t.integer "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "accountable_type"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.integer "wallet_id"
    t.integer "transaction_type"
    t.decimal "amount"
    t.integer "status"
    t.string "comment", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sender_id"
    t.integer "receiver_id"
    t.string "reference_id"
    t.string "custom_message"
    t.integer "gift_type_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "account_id"
    t.decimal "balance", default: "0.0"
    t.string "currency", default: "EUR"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "recurring"
    t.datetime "recurring_cycle_start_time"
    t.integer "period"
    t.decimal "recharge_amount"
  end

  add_foreign_key "account_choice_skin_logs", "accounts"
  add_foreign_key "account_choice_skin_logs", "skin_quizzes"
  add_foreign_key "account_choice_skin_quizzes", "accounts"
  add_foreign_key "account_choice_skin_quizzes", "choices"
  add_foreign_key "account_choice_skin_quizzes", "skin_quizzes"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "automatic_renewals", "accounts"
  add_foreign_key "catalogue_variants", "catalogue_variant_colors"
  add_foreign_key "catalogue_variants", "catalogue_variant_sizes"
  add_foreign_key "catalogue_variants", "catalogues"
  add_foreign_key "catalogues", "brands"
  add_foreign_key "catalogues", "categories"
  add_foreign_key "catalogues", "sub_categories"
  add_foreign_key "catalogues_tags", "catalogues"
  add_foreign_key "catalogues_tags", "tags"
  add_foreign_key "categories_sub_categories", "categories"
  add_foreign_key "categories_sub_categories", "sub_categories"
  add_foreign_key "choice_tags", "choices"
  add_foreign_key "frame_images", "life_events"
  add_foreign_key "notifications", "accounts", column: "accountable_id"
  add_foreign_key "order_services", "shopping_cart_orders"
  add_foreign_key "reviews", "catalogues"
  add_foreign_key "skin_clinic_availabilities", "skin_clinics"
  add_foreign_key "user_consultations", "accounts"
  add_foreign_key "user_events", "accounts"
  add_foreign_key "user_events", "life_events"
  add_foreign_key "user_images", "accounts"
end
