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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20190114222109) do

  create_table "personal_infos", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "country"
    t.string   "phone_no"
    t.string   "postal_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reservations", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "client_demands"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
  end

  add_index "reservations", ["created_at"], :name => "index_reservations_on_created_at"
  add_index "reservations", ["created_at"], :name => "index_reservations_on_user_id_and_created_at"
  add_index "reservations", ["end_date"], :name => "index_reservations_on_user_id_and_end_date"
  add_index "reservations", ["start_date"], :name => "index_reservations_on_user_id_and_start_date"

  create_table "room_reservations", :force => true do |t|
    t.integer  "reservation_id"
    t.integer  "room_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "room_room_types", :force => true do |t|
    t.integer  "room_id"
    t.integer  "room_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "room_room_types", ["room_id", "room_type_id"], :name => "index_room_room_types_on_room_id_and_room_type_id"

  create_table "room_types", :force => true do |t|
    t.string   "room_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "room_view_types", :force => true do |t|
    t.integer  "room_id"
    t.integer  "view_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "room_view_types", ["room_id", "view_type_id"], :name => "index_room_view_types_on_room_id_and_view_type_id"

  create_table "rooms", :force => true do |t|
    t.integer  "floor_no"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "room_no"
  end

  create_table "users", :force => true do |t|
    t.string   "role_id"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "view_types", :force => true do |t|
    t.string   "view_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
