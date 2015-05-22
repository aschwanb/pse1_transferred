class CreateHashtagsTrendings < ActiveRecord::Migration
  def change
    create_table :hashtags_trendings, id: false do |t|
      t.belongs_to :hashtag, index: true
      t.belongs_to  :trending, index: true
    end
  end
end
