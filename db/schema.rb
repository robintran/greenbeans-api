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

ActiveRecord::Schema.define(:version => 20130115080845) do

  create_table "beans", :force => true do |t|
    t.string   "code",                            :null => false
    t.integer  "token_id",                        :null => false
    t.string   "used_on",     :default => "none"
    t.boolean  "is_checkout", :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "beans", ["code"], :name => "index_beans_on_code"
  add_index "beans", ["token_id"], :name => "index_beans_on_token_id"
  add_index "beans", ["used_on"], :name => "index_beans_on_used_on"

  create_table "merchants", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name",                                   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "merchants", ["email"], :name => "index_merchants_on_email", :unique => true
  add_index "merchants", ["name"], :name => "index_merchants_on_name", :unique => true
  add_index "merchants", ["reset_password_token"], :name => "index_merchants_on_reset_password_token", :unique => true

  create_table "prizes", :force => true do |t|
    t.integer  "raffle_id"
    t.text     "tier",       :default => "---\n:first: 0\n:second: 0\n:third: 0\n"
    t.string   "p_type"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  add_index "prizes", ["raffle_id"], :name => "index_prizes_on_raffle_id"

  create_table "raffles", :force => true do |t|
    t.integer  "num_of_winner"
    t.string   "name"
    t.text     "description"
    t.datetime "drawing_time"
    t.boolean  "repeat"
    t.text     "instructions"
    t.integer  "merchant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "raffles", ["merchant_id"], :name => "index_raffles_on_merchant_id"

  create_table "tokens", :force => true do |t|
    t.string   "code",        :null => false
    t.integer  "merchant_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tokens", ["code"], :name => "index_tokens_on_code"
  add_index "tokens", ["merchant_id", "code"], :name => "index_tokens_on_merchant_id_and_code"
  add_index "tokens", ["merchant_id"], :name => "index_tokens_on_merchant_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
