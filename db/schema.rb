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

ActiveRecord::Schema.define(version: 20180427011500) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "post_id"
    t.string   "user_id"
    t.string   "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crawl_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "region"
    t.string   "category"
    t.string   "name"
    t.string   "address"
    t.string   "tags"
    t.string   "is_inside"
    t.string   "is_food_traditional"
    t.string   "is_look_traditional"
    t.string   "near_subway"
    t.string   "x"
    t.string   "y"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "expressions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "crawl_data_id"
    t.string   "category"
    t.string   "type"
    t.string   "language",                    default: "korean"
    t.string   "about"
    t.text     "contents",      limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id"
    t.string   "crawl_datum_id"
    t.string   "title"
    t.text     "contents",       limit: 65535
    t.string   "star"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "user_geocodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id"
    t.string   "user_x"
    t.string   "user_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_selects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id"
    t.string   "location"
    t.string   "feel"
    t.string   "food_traditional"
    t.string   "look_traditional"
    t.string   "inside"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "user_translates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_id"
    t.string   "input"
    t.string   "output"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "nickname"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
