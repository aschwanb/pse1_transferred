class RemoveFieldnameFromHashtagPairs < ActiveRecord::Migration
  def change
    remove_column :hashtag_pairs, :popularity_now, :integer
    remove_column :hashtag_pairs, :popularity_old, :integer
  end
end
