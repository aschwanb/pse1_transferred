class CreateAuthorsHashtags < ActiveRecord::Migration
  def change
    create_table :authors_hashtags, id: false do |t|
      t.belongs_to :author, index: true
      t.belongs_to :hashtag, index: true
    end
  end
end
