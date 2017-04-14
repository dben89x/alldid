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

ActiveRecord::Schema.define(version: 20170413222056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "barber_profiles", force: :cascade do |t|
    t.integer "barber_id"
    t.text    "bio"
    t.index ["barber_id"], name: "index_barber_profiles_on_barber_id", using: :btree
  end

  create_table "barber_services", force: :cascade do |t|
    t.integer "user_id"
    t.integer "service_id"
    t.integer "rate"
    t.integer "minutes"
    t.index ["service_id"], name: "index_barber_services_on_service_id", using: :btree
    t.index ["user_id"], name: "index_barber_services_on_user_id", using: :btree
  end

  create_table "barber_styles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.integer "rate"
    t.integer "minutes"
    t.index ["skill_id"], name: "index_barber_styles_on_skill_id", using: :btree
    t.index ["user_id"], name: "index_barber_styles_on_user_id", using: :btree
  end

  create_table "client_profiles", force: :cascade do |t|
    t.integer "client_id"
    t.integer "hair_type"
    t.integer "hair_width"
    t.integer "hair_density"
    t.integer "perfect_barber_id"
    t.index ["client_id"], name: "index_client_profiles_on_client_id", using: :btree
  end

  create_table "endorsements", force: :cascade do |t|
    t.integer "barber_id"
    t.integer "client_id"
    t.integer "style_id"
    t.index ["barber_id"], name: "index_endorsements_on_barber_id", using: :btree
    t.index ["client_id"], name: "index_endorsements_on_client_id", using: :btree
    t.index ["style_id"], name: "index_endorsements_on_style_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string  "location"
    t.integer "zip"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "hourly_rate"
    t.string  "location"
    t.integer "zip"
    t.integer "haircut_count"
    t.integer "organization_id"
    t.integer "user_id"
    t.integer "current_style_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "avatar"
    t.index ["organization_id"], name: "index_profiles_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "barber_id"
    t.integer "client_id"
    t.text    "text"
    t.integer "rating"
    t.index ["barber_id"], name: "index_ratings_on_barber_id", using: :btree
    t.index ["client_id"], name: "index_ratings_on_client_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
    t.integer  "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["profile_id"], name: "index_users_on_profile_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
