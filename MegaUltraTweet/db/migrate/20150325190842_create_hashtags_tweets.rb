class CreateHashtagsTweets < ActiveRecord::Migration
  def change
    create_table :hashtags_tweets, id: false do |t|
      t.belongs_to :hashtag, index: true
      t.belongs_to :tweet, index: true
    end
  end
end
