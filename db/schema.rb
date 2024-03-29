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

ActiveRecord::Schema.define(version: 20160518142308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "replies", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "wiki_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree
  add_index "replies", ["wiki_id"], name: "index_replies_on_wiki_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.string   "password",   default: "", null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.integer  "level",      default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "wikis", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",      default: 1
  end

  add_index "wikis", ["user_id"], name: "index_wikis_on_user_id", using: :btree

  add_foreign_key "replies", "users"
  add_foreign_key "replies", "wikis"
  add_foreign_key "wikis", "users"
end
