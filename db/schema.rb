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

ActiveRecord::Schema.define(version: 2018_05_20_080155) do

  create_table "bots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "parent_id"
    t.string "message", null: false
    t.text "response"
    t.text "prepend"
    t.text "append"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_bots_on_parent_id"
    t.index ["user_id"], name: "index_bots_on_user_id"
  end

  create_table "gemfiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "user_key"
    t.string "role"
    t.text "remark"
    t.boolean "friend", default: false
    t.boolean "in_chat_room", default: false
    t.boolean "active", default: true
    t.string "connection_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_code"], name: "index_users_on_connection_code", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
