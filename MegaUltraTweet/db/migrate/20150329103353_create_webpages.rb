class CreateWebpages < ActiveRecord::Migration
  def change
    create_table :webpages do |t|
      t.references :tweet, index: true
      t.string :url

      t.timestamps null: false
    end
    add_foreign_key :webpages, :tweets
  end
end
