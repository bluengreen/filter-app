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

ActiveRecord::Schema.define(version: 20150530203402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "keywords"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories_news_items", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "news_item_id"
  end

  add_index "categories_news_items", ["category_id", "news_item_id"], name: "categories_news_items_index", unique: true, using: :btree

  create_table "news_items", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "teaser"
    t.string   "url",          limit: 255
    t.integer  "source_id"
    t.datetime "published_at"
    t.integer  "value"
    t.integer  "fb_likes"
    t.integer  "retweets"
    t.string   "guid",         limit: 255
    t.integer  "linkedin"
    t.integer  "xing"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "gplus"
    t.text     "full_text"
    t.integer  "word_length"
  end

  add_index "news_items", ["guid"], name: "index_news_items_on_guid", using: :btree
  add_index "news_items", ["published_at"], name: "index_news_items_on_published_at", using: :btree
  add_index "news_items", ["source_id"], name: "index_news_items_on_source_id", using: :btree
  add_index "news_items", ["value"], name: "index_news_items_on_value", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string   "type",               limit: 255
    t.string   "url",                limit: 255
    t.string   "name",               limit: 255
    t.integer  "value"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "logo_file_name",     limit: 255
    t.string   "logo_content_type",  limit: 255
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "full_text_selector", limit: 255
  end

  add_index "sources", ["type"], name: "index_sources_on_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",                    default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
