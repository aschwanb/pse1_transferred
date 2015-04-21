class CreateAuthorHashtagPairs < ActiveRecord::Migration
  def change
    create_table :author_hashtag_pairs do |t|
      t.belongs_to :author, index: true
      t.belongs_to :hashtag, index: true

      t.timestamps null: false
    end
  end
end
