class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string  :name
      t.string  :screen_name
      t.integer :twitter_id, limit: 8 # bigint (8 bytes)
      t.integer :friends_count
      t.integer :followers_count

      t.timestamps null: false
    end
  end
end
