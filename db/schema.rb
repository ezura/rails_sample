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

ActiveRecord::Schema.define(version: 20141220093742) do

  create_table "documents", force: true do |t|
    t.integer  "previous_version", default: 0, null: false
    t.text     "contents"
    t.text     "meta"
    t.text     "tmp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",          default: 0
  end

  create_table "logs", force: true do |t|
    t.integer  "document_id",  null: false
    t.integer  "version",      null: false
    t.text     "contents"
    t.text     "meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "version_name"
  end

  add_index "logs", ["version_name"], name: "index_logs_on_version_name"

end
