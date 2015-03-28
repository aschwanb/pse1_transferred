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

ActiveRecord::Schema.define(version: 20150328203113) do

  create_table "authors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hashtags_tweets", id: false, force: :cascade do |t|
    t.integer "hashtag_id", limit: 4
    t.integer "tweet_id",   limit: 4
  end

  add_index "hashtags_tweets", ["hashtag_id"], name: "index_hashtags_tweets_on_hashtag_id", using: :btree
  add_index "hashtags_tweets", ["tweet_id"], name: "index_hashtags_tweets_on_tweet_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "retweets",   limit: 4
    t.integer  "author_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "twitter_id", limit: 8
  end

  add_index "tweets", ["author_id"], name: "index_tweets_on_author_id", using: :btree

  add_foreign_key "tweets", "authors"
end
