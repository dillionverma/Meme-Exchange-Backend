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

ActiveRecord::Schema.define(version: 20200413004406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meme_histories", force: :cascade do |t|
    t.bigint "meme_id"
    t.string "reddit_id"
    t.bigint "price"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_meme_histories_on_meme_id"
  end

  create_table "meme_portfolios", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meme_id"
    t.bigint "cost", default: 0
    t.bigint "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_meme_portfolios_on_meme_id"
    t.index ["user_id"], name: "index_meme_portfolios_on_user_id"
  end

  create_table "memes", force: :cascade do |t|
    t.string "title"
    t.string "subreddit"
    t.string "author"
    t.text "url"
    t.text "permalink"
    t.bigint "quantity", default: 0
    t.string "reddit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "third_party_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider_name"
    t.string "provider_side_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_third_party_identities_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.bigint "price", default: 0
    t.bigint "quantity", default: 0
    t.bigint "user_id"
    t.bigint "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_transactions_on_meme_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "coins", default: 1000
    t.string "username"
    t.string "avatar"
    t.boolean "active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meme_histories", "memes"
  add_foreign_key "meme_portfolios", "memes"
  add_foreign_key "meme_portfolios", "users"
  add_foreign_key "third_party_identities", "users"
  add_foreign_key "transactions", "memes"
  add_foreign_key "transactions", "users"
end
