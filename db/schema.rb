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

ActiveRecord::Schema.define(version: 2021_06_07_234715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

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

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "hash_tag"
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categories_news_items", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "news_item_id"
    t.index ["category_id", "news_item_id"], name: "categories_news_items_index", unique: true
  end

  create_table "categories_trends_words", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "trends_word_id"
    t.index ["category_id", "trends_word_id"], name: "categories_trends_words_index", unique: true
    t.index ["category_id"], name: "index_categories_trends_words_on_category_id"
    t.index ["trends_word_id"], name: "index_categories_trends_words_on_trends_word_id"
  end

  create_table "impressions", id: :serial, force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "params"
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "linkages", id: :serial, force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "different", default: false
    t.index ["from_id"], name: "index_linkages_on_from_id"
    t.index ["to_id"], name: "index_linkages_on_to_id"
  end

  create_table "news_items", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "teaser"
    t.string "url"
    t.integer "source_id"
    t.datetime "published_at"
    t.integer "value"
    t.integer "fb_likes"
    t.integer "retweets"
    t.string "guid"
    t.integer "xing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "full_text"
    t.integer "word_length"
    t.text "plaintext"
    t.tsvector "search_vector"
    t.integer "incoming_link_count"
    t.float "absolute_score"
    t.boolean "blacklisted", default: false
    t.integer "reddit"
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.integer "impression_count", default: 0
    t.string "tweet_id"
    t.integer "absolute_score_per_halflife"
    t.integer "youtube_likes", default: 0
    t.integer "youtube_views", default: 0
    t.integer "category_order", array: true
    t.integer "dupe_of_id"
    t.boolean "trend_analyzed", default: false
    t.boolean "paywall", default: false
    t.index ["absolute_score", "published_at"], name: "index_news_items_on_absolute_score_and_published_at"
    t.index ["absolute_score"], name: "index_news_items_on_absolute_score"
    t.index ["absolute_score_per_halflife"], name: "index_news_items_on_absolute_score_per_halflife"
    t.index ["dupe_of_id"], name: "index_news_items_on_dupe_of_id"
    t.index ["guid"], name: "index_news_items_on_guid"
    t.index ["published_at"], name: "index_news_items_on_published_at"
    t.index ["search_vector"], name: "index_news_items_on_search_vector", using: :gin
    t.index ["source_id"], name: "index_news_items_on_source_id"
    t.index ["value"], name: "index_news_items_on_value"
  end

  create_table "push_notifications", force: :cascade do |t|
    t.string "device_hash"
    t.integer "response", default: 0
    t.text "error_response"
    t.json "push_payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "os"
    t.string "app_version"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.index ["key"], name: "index_settings_on_key", unique: true
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "url"
    t.string "name"
    t.integer "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "full_text_selector"
    t.boolean "error"
    t.float "multiplicator", default: 1.0
    t.boolean "lsr_active", default: false
    t.boolean "deactivated", default: false
    t.integer "default_category_id"
    t.string "lsr_confirmation_file_name"
    t.string "lsr_confirmation_content_type"
    t.bigint "lsr_confirmation_file_size"
    t.datetime "lsr_confirmation_updated_at"
    t.string "twitter_account"
    t.string "language"
    t.text "comment"
    t.text "filter_rules"
    t.json "statistics"
    t.text "error_message"
    t.text "url_rules"
    t.string "image_candidates", array: true
    t.index ["type"], name: "index_sources_on_type"
  end

  create_table "trends_trends", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_trends_trends_on_slug", unique: true
  end

  create_table "trends_usages", id: :serial, force: :cascade do |t|
    t.integer "word_id"
    t.integer "news_item_id"
    t.integer "source_id"
    t.string "calendar_week"
    t.date "date"
    t.integer "usage_type", default: 0
    t.boolean "dupe", default: false
    t.index ["calendar_week"], name: "index_trends_usages_on_calendar_week"
    t.index ["date"], name: "index_trends_usages_on_date"
    t.index ["dupe"], name: "index_trends_usages_on_dupe"
    t.index ["news_item_id"], name: "index_trends_usages_on_news_item_id"
    t.index ["source_id"], name: "index_trends_usages_on_source_id"
    t.index ["usage_type"], name: "index_trends_usages_on_usage_type"
    t.index ["word_id"], name: "index_trends_usages_on_word_id"
  end

  create_table "trends_words", id: :serial, force: :cascade do |t|
    t.string "word"
    t.boolean "ignore"
    t.integer "word_type", default: 0
    t.integer "trend_id"
    t.index ["ignore"], name: "index_trends_words_on_ignore"
    t.index ["trend_id"], name: "index_trends_words_on_trend_id"
    t.index ["word"], name: "index_trends_words_on_word", unique: true
    t.index ["word_type"], name: "index_trends_words_on_word_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "trends_usages", "news_items"
  add_foreign_key "trends_usages", "sources"
end
