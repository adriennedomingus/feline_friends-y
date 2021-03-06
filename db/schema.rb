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

ActiveRecord::Schema.define(version: 20160308225524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "state"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cat_orders", force: :cascade do |t|
    t.integer  "cat_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cat_orders", ["cat_id"], name: "index_cat_orders_on_cat_id", using: :btree
  add_index "cat_orders", ["order_id"], name: "index_cat_orders_on_order_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.string   "age"
    t.datetime "created_at",                                                                                                           null: false
    t.datetime "updated_at",                                                                                                           null: false
    t.string   "description"
    t.integer  "price"
    t.integer  "category_id"
    t.string   "status",      default: "active"
    t.string   "image",       default: "https://s-media-cache-ak0.pinimg.com/originals/96/cb/f1/96cbf1cb56de8d012513832d664d0902.gif"
  end

  add_index "cats", ["category_id"], name: "index_cats_on_category_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status",       default: 0
    t.datetime "cancelled_at"
    t.datetime "returned_at"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "score"
    t.string   "comment"
    t.integer  "cat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "reviews", ["cat_id"], name: "index_reviews_on_cat_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.integer  "address_id"
  end

  add_index "users", ["address_id"], name: "index_users_on_address_id", using: :btree

  add_foreign_key "cat_orders", "cats"
  add_foreign_key "cat_orders", "orders"
  add_foreign_key "cats", "categories"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "cats"
  add_foreign_key "reviews", "users"
  add_foreign_key "users", "addresses"
end
