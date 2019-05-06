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

ActiveRecord::Schema.define(version: 2019_05_05_221847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_count"
    t.index ["university_id"], name: "index_comments_on_university_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.integer "student_count"
    t.text "street_address"
    t.string "city"
    t.string "state"
    t.integer "q1_act"
    t.integer "q3_act"
    t.float "acceptance_rate"
    t.float "cost_in"
    t.float "cost_out"
    t.integer "institution_type"
    t.integer "year_founded"
    t.text "school_site"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip_code"
    t.integer "q1_sat_reading"
    t.integer "q3_sat_reading"
    t.integer "q1_sat_math"
    t.integer "q3_sat_math"
    t.index ["id"], name: "index_universities_on_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.boolean "mod"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "universities"
  add_foreign_key "comments", "users"
end
