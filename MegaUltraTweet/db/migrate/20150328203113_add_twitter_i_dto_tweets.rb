class AddTwitterIDtoTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_id, :integer, limit: 8   # bigint (8 bytes)
  end
end
