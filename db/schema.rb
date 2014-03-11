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

ActiveRecord::Schema.define(version: 20140311190724) do

  create_table "anticipated_fundings", force: true do |t|
    t.integer  "presentation_id"
    t.string   "description"
    t.decimal  "amount"
    t.string   "anticipated_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
  end

  add_index "anticipated_fundings", ["currency_id"], name: "index_anticipated_fundings_on_currency_id", using: :btree
  add_index "anticipated_fundings", ["presentation_id"], name: "index_anticipated_fundings_on_presentation_id", using: :btree

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.integer  "person_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friend_id"], name: "index_friends_on_friend_id", using: :btree
  add_index "friends", ["person_id"], name: "index_friends_on_person_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "presentations", force: true do |t|
    t.boolean  "similar_project"
    t.integer  "user_id"
    t.boolean  "completely_read"
    t.string   "research_school_title"
    t.string   "project_type"
    t.string   "subject_clasification"
    t.string   "school_place"
    t.text     "scientific_content"
    t.text     "members_of_scientific_committee"
    t.text     "members_of_local_committee"
    t.text     "local_institution_description"
    t.text     "motivation"
    t.text     "related_scientific_work"
    t.text     "infrastructure"
    t.text     "course1"
    t.text     "tentative_schedule"
    t.integer  "women_percentage_scientific"
    t.integer  "women_percentage_local"
    t.integer  "women_percentage_course"
    t.float    "how_much_cimpa"
    t.integer  "how_much_cimpa_percentage"
    t.integer  "young_people"
    t.float    "average_time_scientific"
    t.integer  "day_time_scientific"
    t.boolean  "confirmation_completely_read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "administration_name"
    t.string   "administration_place"
    t.string   "administration_email"
    t.string   "administration_phone"
    t.string   "administration_cv_file_name"
    t.string   "administration_cv_content_type"
    t.integer  "administration_cv_file_size"
    t.datetime "administration_cv_updated_at"
    t.string   "scientific_name"
    t.string   "scientific_place"
    t.string   "scientific_email"
    t.string   "scientific_phone"
    t.string   "scientific_cv_file_name"
    t.string   "scientific_cv_content_type"
    t.integer  "scientific_cv_file_size"
    t.datetime "scientific_cv_updated_at"
    t.string   "proposal_state"
    t.datetime "pre_proposal_date"
    t.datetime "final_proposal_date"
    t.text     "comment"
    t.text     "course2"
    t.text     "course3"
    t.text     "course4"
    t.text     "course5"
    t.text     "course6"
    t.date     "school_date_a_start"
    t.date     "school_date_a_finish"
    t.date     "school_date_b_start"
    t.date     "school_date_b_finish"
    t.string   "school_country"
    t.string   "administration_country"
    t.string   "scientific_country"
    t.string   "tentative_schedule_file_file_name"
    t.string   "tentative_schedule_file_content_type"
    t.integer  "tentative_schedule_file_file_size"
    t.datetime "tentative_schedule_file_updated_at"
  end

  add_index "presentations", ["user_id"], name: "index_presentations_on_user_id", using: :btree

  create_table "provisional_budgets", force: true do |t|
    t.integer  "presentation_id"
    t.string   "description"
    t.decimal  "amount"
    t.string   "provisional_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
  end

  add_index "provisional_budgets", ["currency_id"], name: "index_provisional_budgets_on_currency_id", using: :btree
  add_index "provisional_budgets", ["presentation_id"], name: "index_provisional_budgets_on_presentation_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
