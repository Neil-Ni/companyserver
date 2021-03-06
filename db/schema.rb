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

ActiveRecord::Schema.define(version: 20170310014657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.integer  "user_id"
    t.index ["company_id"], name: "index_admins_on_company_id", using: :btree
    t.index ["user_id"], name: "index_admins_on_user_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                    default: "",                 null: false
    t.string   "default_day_week_starts", default: "monday",           null: false
    t.boolean  "archived",                default: false,              null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "default_time_zone",       default: "America/New_York", null: false
  end

  create_table "directories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.integer  "user_id"
    t.index ["company_id"], name: "index_directories_on_company_id", using: :btree
    t.index ["user_id"], name: "index_directories_on_user_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name",       default: "",       null: false
    t.string   "color",      default: "48B7AB", null: false
    t.boolean  "archived",   default: false,    null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "team_id"
    t.index ["team_id"], name: "index_jobs_on_team_id", using: :btree
  end

  create_table "managers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "team_id"
    t.integer  "user_id"
    t.index ["team_id"], name: "index_managers_on_team_id", using: :btree
    t.index ["user_id"], name: "index_managers_on_user_id", using: :btree
  end

  create_table "shifts", force: :cascade do |t|
    t.boolean  "published",  default: false, null: false
    t.datetime "start",                      null: false
    t.datetime "stop",                       null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "team_id"
    t.integer  "job_id"
    t.integer  "user_id"
    t.index ["job_id"], name: "index_shifts_on_job_id", using: :btree
    t.index ["team_id"], name: "index_shifts_on_team_id", using: :btree
    t.index ["user_id"], name: "index_shifts_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",            default: "",       null: false
    t.string   "timezone",        default: "",       null: false
    t.string   "day_week_starts", default: "monday", null: false
    t.string   "color",           default: "48B7AB", null: false
    t.boolean  "archived",        default: false,    null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "company_id"
    t.index ["company_id"], name: "index_teams_on_company_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phonenumber"
    t.boolean  "admin",                  default: false, null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "company_id"
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "workers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "team_id"
    t.integer  "user_id"
    t.index ["team_id"], name: "index_workers_on_team_id", using: :btree
    t.index ["user_id"], name: "index_workers_on_user_id", using: :btree
  end

end
