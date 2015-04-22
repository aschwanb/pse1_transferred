class AddPopularityToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :popularity_now, :int
    add_column :hashtags, :populairity_old, :int
  end
end
