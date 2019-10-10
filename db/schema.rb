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

ActiveRecord::Schema.define(version: 2019_10_06_114900) do

  create_table "addresses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "postal_code", null: false
    t.string "address_prefecture", null: false
    t.string "address_city", null: false
    t.string "address_number", null: false
    t.string "address_building"
    t.string "address_phone"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.text "text", null: false
    t.integer "status", null: false
    t.string "stage", null: false
    t.string "delivery_responsivility", null: false
    t.string "delivery_way", null: false
    t.string "delivery_area", null: false
    t.string "delivery_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.integer "birthdate_year", null: false
    t.integer "birthdate_month", null: false
    t.integer "birthdate_day", null: false
    t.string "phone_number", null: false
    t.string "nickname", null: false
    t.text "text"
    t.string "image"
    t.integer "good", default: 0
    t.integer "normal", default: 0
    t.integer "bat", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
