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

ActiveRecord::Schema.define(version: 20150426081400) do

  create_table "author_hashtags", force: :cascade do |t|
    t.integer "author_id",  limit: 4
    t.integer "hashtag_id", limit: 4
  end

  add_index "author_hashtags", ["author_id"], name: "index_author_hashtags_on_author_id", using: :btree
  add_index "author_hashtags", ["hashtag_id"], name: "index_author_hashtags_on_hashtag_id", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "screen_name",     limit: 255
    t.integer  "twitter_id",      limit: 8
    t.integer  "friends_count",   limit: 4
    t.integer  "followers_count", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "hashtag_hashtags", force: :cascade do |t|
    t.integer  "hashtag_first_id",  limit: 4
    t.integer  "hashtag_second_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hashtags_startingpoints", id: false, force: :cascade do |t|
    t.integer "hashtag_id",       limit: 4
    t.integer "startingpoint_id", limit: 4
  end

  add_index "hashtags_startingpoints", ["hashtag_id"], name: "index_hashtags_startingpoints_on_hashtag_id", using: :btree
  add_index "hashtags_startingpoints", ["startingpoint_id"], name: "index_hashtags_startingpoints_on_startingpoint_id", using: :btree

  create_table "hashtags_trendings", id: false, force: :cascade do |t|
    t.integer "hashtag_id",  limit: 4
    t.integer "trending_id", limit: 4
  end

  add_index "hashtags_trendings", ["hashtag_id"], name: "index_hashtags_trendings_on_hashtag_id", using: :btree
  add_index "hashtags_trendings", ["trending_id"], name: "index_hashtags_trendings_on_trending_id", using: :btree

  create_table "hashtags_tweets", id: false, force: :cascade do |t|
    t.integer "hashtag_id", limit: 4
    t.integer "tweet_id",   limit: 4
  end

  add_index "hashtags_tweets", ["hashtag_id"], name: "index_hashtags_tweets_on_hashtag_id", using: :btree
  add_index "hashtags_tweets", ["tweet_id"], name: "index_hashtags_tweets_on_tweet_id", using: :btree

  create_table "popularities", force: :cascade do |t|
    t.integer  "popular_id",   limit: 4
    t.string   "popular_type", limit: 255
    t.text     "times_used",   limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "popularities", ["popular_id"], name: "index_popularities_on_popular_id", using: :btree

  create_table "startingpoints", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trendings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "retweets",   limit: 4
    t.integer  "twitter_id", limit: 8
    t.integer  "author_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tweets", ["author_id"], name: "index_tweets_on_author_id", using: :btree

  create_table "tweets_webpages", id: false, force: :cascade do |t|
    t.integer "tweet_id",   limit: 4
    t.integer "webpage_id", limit: 4
  end

  add_index "tweets_webpages", ["tweet_id"], name: "index_tweets_webpages_on_tweet_id", using: :btree
  add_index "tweets_webpages", ["webpage_id"], name: "index_tweets_webpages_on_webpage_id", using: :btree

  create_table "webpages", force: :cascade do |t|
    t.string   "url",         limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
