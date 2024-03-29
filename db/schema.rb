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

ActiveRecord::Schema.define(:version => 20130701021723) do

  create_table "host_categories", :force => true do |t|
    t.string   "host"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "timeline_tweets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tweet_id",   :limit => 8
    t.boolean  "favorited"
    t.boolean  "retweeted"
    t.datetime "read_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "tweets", :force => true do |t|
    t.integer  "favorite_count"
    t.integer  "twitter_user_id",    :limit => 8
    t.integer  "retweet_count"
    t.boolean  "possibly_sensitive"
    t.string   "text"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_article"
    t.string   "text_stripped"
  end

  create_table "twitter_users", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "favourites_count"
    t.integer  "friends_count"
    t.integer  "followers_count"
    t.string   "profile_image_url"
    t.string   "screen_name"
    t.string   "time_zone"
    t.boolean  "verified"
    t.boolean  "protected"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "url_entities", :force => true do |t|
    t.integer  "tweet_id",           :limit => 8
    t.string   "expanded_url"
    t.string   "fully_expanded_url"
    t.integer  "indice_start"
    t.integer  "indice_end"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "host_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.integer  "twitter_user_id",        :limit => 8
    t.string   "token"
    t.string   "secret"
    t.integer  "since_id",               :limit => 8
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
