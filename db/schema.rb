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

ActiveRecord::Schema.define(version: 20160424013641) do

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
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.text     "why"
    t.string   "github_url"
    t.datetime "accepted_at"
    t.datetime "refunded_at"
    t.text     "refund_reason"
    t.integer  "refund_amount"
    t.date     "last_contacted_on"
    t.datetime "rejected_at"
    t.datetime "interview_invitation_sent_at"
    t.boolean  "paused",                       default: false, null: false
    t.string   "promo_code"
    t.integer  "payment_count",                default: 6,     null: false
    t.decimal  "multiplier",                   default: 1.0,   null: false
  end

  create_table "instructors", force: :cascade do |t|
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
    t.string   "name",                   default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "instructors", ["email"], name: "index_instructors_on_email", unique: true, using: :btree
  add_index "instructors", ["reset_password_token"], name: "index_instructors_on_reset_password_token", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "enrollment_id"
    t.string   "token"
    t.string   "auth_code"
    t.integer  "amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "payments", ["enrollment_id"], name: "index_payments_on_enrollment_id", using: :btree

  create_table "private_sessions", force: :cascade do |t|
    t.integer  "student_id"
    t.text     "notes",         default: "", null: false
    t.datetime "started_at",                 null: false
    t.datetime "ended_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "instructor_id"
    t.text     "homework"
  end

  add_index "private_sessions", ["instructor_id"], name: "index_private_sessions_on_instructor_id", using: :btree
  add_index "private_sessions", ["student_id"], name: "index_private_sessions_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.integer  "enrollment_id", null: false
    t.text     "notes"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "affiliate_sales", "affiliates"
  add_foreign_key "affiliate_sales", "enrollments"
  add_foreign_key "payments", "enrollments"
  add_foreign_key "private_sessions", "instructors"
  add_foreign_key "private_sessions", "students"
end
