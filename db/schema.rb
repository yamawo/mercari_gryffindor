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

ActiveRecord::Schema.define(version: 20191006052724) do

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                  null: false
    t.integer  "price",                                 null: false
    t.text     "text",                    limit: 65535, null: false
    t.integer  "status",                                null: false
    t.string   "stage",                                 null: false
    t.string   "delivery_responsivility",               null: false
    t.string   "delivery_way",                          null: false
    t.string   "delivery_area",                         null: false
    t.string   "delivery_day",                          null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
