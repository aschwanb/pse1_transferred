class CreateAuthorsHashtags < ActiveRecord::Migration
  def change
    create_table :author_hashtags do |t|
      t.integer :author_id
      t.integer :hashtag_id
    end

    add_index :author_hashtags, :author_id
    add_index :author_hashtags, :hashtag_id
  end
end