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

ActiveRecord::Schema.define(version: 20180202112256) do

  create_table "advices", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "author"
    t.datetime "writtenAt"

  create_table "pw_new_admins", force: true do |t|
    t.string   "pw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pw_new_professores", force: true do |t|
    t.string   "pw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_admins", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "user_admins", ["email"], name: "index_user_admins_on_email", unique: true
  add_index "user_admins", ["username"], name: "index_user_admins_on_username", unique: true

  create_table "user_professores", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "user_professores", ["email"], name: "index_user_professores_on_email", unique: true
  add_index "user_professores", ["username"], name: "index_user_professores_on_username", unique: true

  create_table "user_studentes", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "username"
    t.string   "fiscalCode"
    t.date     "birthDay"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "user_studentes", ["email"], name: "index_user_studentes_on_email", unique: true
  add_index "user_studentes", ["fiscalCode"], name: "index_user_studentes_on_fiscalCode", unique: true
  add_index "user_studentes", ["username"], name: "index_user_studentes_on_username", unique: true

end
