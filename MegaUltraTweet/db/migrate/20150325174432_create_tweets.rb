class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :retweets
      t.references :author, index: true

      t.timestamps null: false
    end
    add_foreign_key :tweets, :authors
  end
end
