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

ActiveRecord::Schema.define(version: 20161213013715) do

  create_table "notes", force: :cascade do |t|
    t.text     "detail",      limit: 500
    t.integer  "prospect_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["prospect_id"], name: "index_notes_on_prospect_id"
  end

  create_table "prospects", force: :cascade do |t|
    t.string   "campaign",          limit: 64
    t.integer  "list_number",       limit: 10
    t.time     "time_on_contact"
    t.string   "status",            limit: 32
    t.string   "source",            limit: 32
    t.string   "company",           limit: 64
    t.string   "company_phone",     limit: 32
    t.string   "address",           limit: 64
    t.string   "address2",          limit: 32
    t.string   "city",              limit: 32
    t.string   "state",             limit: 64
    t.string   "zip",               limit: 16
    t.string   "county",            limit: 64
    t.string   "fax",               limit: 32
    t.string   "website",           limit: 128
    t.string   "numberofemployees", limit: 64
    t.string   "first_name",        limit: 64
    t.string   "last_name",         limit: 64
    t.string   "title",             limit: 64
    t.string   "phone",             limit: 32
    t.string   "m_phone",           limit: 32
    t.string   "email",             limit: 254
    t.string   "alt_email",         limit: 254
    t.string   "linkedin",          limit: 128
    t.string   "facebook",          limit: 128
    t.date     "born_on"
    t.string   "first_name_2",      limit: 32
    t.string   "last_name_2",       limit: 64
    t.string   "title_2",           limit: 64
    t.string   "phone_2",           limit: 64
    t.string   "m_phone_2",         limit: 32
    t.string   "email_2",           limit: 32
    t.string   "alt_email_2",       limit: 254
    t.string   "linkedin_2",        limit: 254
    t.string   "facebook_2",        limit: 128
    t.date     "born_on_2"
    t.string   "first_name_3",      limit: 64
    t.string   "last_name_3",       limit: 64
    t.string   "title_3",           limit: 64
    t.string   "phone_3",           limit: 32
    t.string   "m_phone_3",         limit: 32
    t.string   "email_3",           limit: 254
    t.string   "alt_email_3",       limit: 254
    t.string   "linkedin_3",        limit: 128
    t.string   "facebook_3",        limit: 128
    t.date     "born_on_3"
    t.string   "other1",            limit: 64
    t.string   "other2",            limit: 64
    t.string   "other3",            limit: 64
    t.string   "other4",            limit: 64
    t.string   "other5",            limit: 64
    t.string   "other6",            limit: 64
    t.string   "other7",            limit: 64
    t.string   "other8",            limit: 64
    t.datetime "eventdatetime"
    t.string   "sic",               limit: 64
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "user_id"
    t.integer  "primary_contact"
    t.boolean  "canvassed",                     default: false
    t.boolean  "called",                        default: false
    t.index ["user_id"], name: "index_prospects_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.string   "disposition"
    t.datetime "event"
    t.integer  "prospect_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "location"
    t.string   "activity"
    t.float    "coordinates"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["prospect_id"], name: "index_results_on_prospect_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
