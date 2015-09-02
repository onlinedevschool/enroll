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

ActiveRecord::Schema.define(version: 20150902184517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliate_sales", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.integer  "affiliate_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "affiliate_sales", ["affiliate_id"], name: "index_affiliate_sales_on_affiliate_id", using: :btree
  add_index "affiliate_sales", ["enrollment_id"], name: "index_affiliate_sales_on_enrollment_id", using: :btree

  create_table "affiliates", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "weeks"
    t.integer  "price"
    t.string   "stripe_id"
    t.boolean  "financed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.string   "token"
    t.string   "auth_code"
    t.integer  "amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "payments", ["enrollment_id"], name: "index_payments_on_enrollment_id", using: :btree

  add_foreign_key "affiliate_sales", "affiliates"
  add_foreign_key "affiliate_sales", "enrollments"
  add_foreign_key "payments", "enrollments"
end
