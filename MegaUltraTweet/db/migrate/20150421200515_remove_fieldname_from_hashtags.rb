class RemoveFieldnameFromHashtags < ActiveRecord::Migration
  def change
    remove_column :hashtags, :popularity_now, :integer
    remove_column :hashtags, :popularity_old, :integer
  end
end
