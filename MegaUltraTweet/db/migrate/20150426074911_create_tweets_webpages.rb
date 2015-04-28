class CreateTweetsWebpages < ActiveRecord::Migration
  def change
    create_table :tweets_webpages, id: false do |t|
      t.belongs_to  :tweet, index: true
      t.belongs_to  :webpage, index: true
    end
  end
end
