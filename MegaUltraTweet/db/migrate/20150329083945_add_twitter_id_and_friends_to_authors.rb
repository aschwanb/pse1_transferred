class AddTwitterIdAndFriendsToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :twitter_id, :integer, limit: 8 # bigint (8 bytes)
    add_column :authors, :friends_count, :integer
  end
end
