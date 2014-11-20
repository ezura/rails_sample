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

ActiveRecord::Schema.define(version: 20141120121057) do

  create_table "documents", force: true do |t|
    t.integer  "previous_version", default: 0, null: false
    t.text     "contents"
    t.text     "meta"
    t.text     "tmp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "document_id",      null: false
    t.integer  "version",          null: false
    t.text     "contents"
    t.text     "meta"
    t.integer  "previous_version", null: false
    t.integer  "next_version",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.integer  "document_id", null: false
    t.integer  "version",     null: false
    t.text     "contents"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
