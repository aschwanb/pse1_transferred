class CreateHashtagPairs < ActiveRecord::Migration
  def change
    create_table :hashtag_pairs do |t|
      t.integer :popularity_now
      t.integer :popularity_old
      t.integer :hashtag_first_id
      t.integer :hashtag_second_id

      t.timestamps null: false
    end

  end
end
