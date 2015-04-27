class CreateHashtagsHashtags < ActiveRecord::Migration
  def change
    create_table :hashtag_hashtags do |t|
      t.integer :hashtag_first_id
      t.integer :hashtag_second_id

      t.timestamps null: false
    end

  end
end
