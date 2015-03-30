class CreateHashtagsTweets < ActiveRecord::Migration
  def change
    create_table :hashtags_tweets, :id => false do |t|
      t.integer :hashtag_id
      t.integer :tweet_id
    end

    add_index :hashtags_tweets, :hashtag_id
    add_index :hashtags_tweets, :tweet_id
  end
end
