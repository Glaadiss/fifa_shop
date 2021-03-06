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

ActiveRecord::Schema.define(version: 20170227225446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "facebook_or_skype"
    t.string   "console_type"
    t.string   "console_email"
    t.string   "console_password"
    t.datetime "console_data"
    t.string   "web_email"
    t.string   "web_password"
    t.string   "web_answer"
    t.string   "origin_answer"
    t.string   "origin_email"
    t.string   "origin_password"
    t.string   "payment_method"
    t.string   "payment_email"
    t.boolean  "confirmed"
    t.string   "failures"
    t.string   "token"
    t.integer  "user_id"
    t.string   "language"
    t.string   "market_blocked"
    t.string   "other_failure"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "new_fields"
    t.string   "phone"
    t.string   "recommend"
    t.boolean  "paid?"
    t.string   "ip"
  end

  create_table "app_configurations", force: :cascade do |t|
    t.boolean  "work?",      default: false
    t.float    "x1_pln",     default: 20.0
    t.float    "x1_coins",   default: 50000.0
    t.float    "x1_psc",     default: 20.0
    t.float    "x1_eur",     default: 5.0
    t.float    "x3_pln",     default: 10.0
    t.float    "x3_coins",   default: 20000.0
    t.float    "x3_psc",     default: 10.0
    t.float    "x3_eur",     default: 3.0
    t.float    "ps4_pln",    default: 20.0
    t.float    "ps4_coins",  default: 50000.0
    t.float    "ps4_psc",    default: 20.0
    t.float    "ps4_eur",    default: 5.0
    t.float    "ps3_pln",    default: 10.0
    t.float    "ps3_coins",  default: 10000.0
    t.float    "ps3_psc",    default: 5.0
    t.float    "ps3_eur",    default: 4.0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "blocked_ips", force: :cascade do |t|
    t.string   "ip"
    t.string   "name"
    t.string   "descrption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.boolean  "complete?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.integer  "overall"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["account_id"], name: "index_players_on_account_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "players", "accounts"
end
