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

ActiveRecord::Schema.define(version: 20180206162535) do

  create_table "advices", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "author"
    t.datetime "writtenAt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competition_subscribeds", force: true do |t|
    t.integer  "id_user"
    t.integer  "score"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: true do |t|
    t.integer  "id_user"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "otps", force: true do |t|
    t.integer  "id_user"
    t.string   "otp_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pretest_and_exam_quizzes", force: true do |t|
    t.string   "text1"
    t.string   "ans1_1"
    t.string   "ans1_2"
    t.string   "ans1_3"
    t.string   "ans1_4"
    t.integer  "ans1_ok"
    t.string   "text2"
    t.string   "ans2_1"
    t.string   "ans2_2"
    t.string   "ans2_3"
    t.string   "ans2_4"
    t.integer  "ans2_ok"
    t.string   "text3"
    t.string   "ans3_1"
    t.string   "ans3_2"
    t.string   "ans3_3"
    t.string   "ans3_4"
    t.integer  "ans3_ok"
    t.string   "text4"
    t.string   "ans4_1"
    t.string   "ans4_2"
    t.string   "ans4_3"
    t.string   "ans4_4"
    t.integer  "ans4_ok"
    t.string   "text5"
    t.string   "ans5_1"
    t.string   "ans5_2"
    t.string   "ans5_3"
    t.string   "ans5_4"
    t.integer  "ans5_ok"
    t.string   "text6"
    t.string   "ans6_1"
    t.string   "ans6_2"
    t.string   "ans6_3"
    t.string   "ans6_4"
    t.integer  "ans6_ok"
    t.string   "text7"
    t.string   "ans7_1"
    t.string   "ans7_2"
    t.string   "ans7_3"
    t.string   "ans7_4"
    t.integer  "ans7_ok"
    t.string   "text8"
    t.string   "ans8_1"
    t.string   "ans8_2"
    t.string   "ans8_3"
    t.string   "ans8_4"
    t.integer  "ans8_ok"
    t.string   "text9"
    t.string   "ans9_1"
    t.string   "ans9_2"
    t.string   "ans9_3"
    t.string   "ans9_4"
    t.integer  "ans9_ok"
    t.string   "text10"
    t.string   "ans10_1"
    t.string   "ans10_2"
    t.string   "ans10_3"
    t.string   "ans10_4"
    t.integer  "ans10_ok"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "ans1"
    t.string   "ans2"
    t.string   "ans3"
    t.string   "ans4"
    t.integer  "ans_ok"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribe_and_exam_activations", force: true do |t|
    t.boolean  "subscribe"
    t.boolean  "exam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_activations", force: true do |t|
    t.boolean  "activated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_averages", force: true do |t|
    t.integer  "id_user"
    t.float    "my_average"
    t.integer  "ntest"
    t.integer  "year"
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
