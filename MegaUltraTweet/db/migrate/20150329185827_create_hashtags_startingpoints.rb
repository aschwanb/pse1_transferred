class CreateHashtagsStartingpoints < ActiveRecord::Migration
  def change
    create_table :hashtags_startingpoints, id: false do |t|
      t.belongs_to :hashtag, index: true
      t.belongs_to :startingpoint, index: true
    end
  end
end
