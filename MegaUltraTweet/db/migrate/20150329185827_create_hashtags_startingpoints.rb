class CreateHashtagsStartingpoints < ActiveRecord::Migration
  def change
    create_table :hashtags_startingpoints, :id => false do |t|
      t.integer :hashtag_id
      t.integer :startingpoint_id
    end

    add_index :hashtags_startingpoints, :hashtag_id
    add_index :hashtags_startingpoints, :startingpoint_id
  end
end
