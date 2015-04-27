class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  :text
      t.integer :retweets
      t.integer :rank
      t.integer :twitter_id, limit: 8 # bigint (8 bytes)
      t.belongs_to :author, index: true

      t.timestamps null: false
    end
  end
end
