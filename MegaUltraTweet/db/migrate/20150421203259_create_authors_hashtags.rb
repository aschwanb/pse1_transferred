class CreateAuthorsHashtags < ActiveRecord::Migration
  def change
    create_table :author_hashtags do |t|
      t.integer :author_id
      t.integer :hashtag_id
      t.boolean :new_short, default: true
      t.boolean :new_long, default: true
    end

    add_index :author_hashtags, :author_id
    add_index :author_hashtags, :hashtag_id
  end
end