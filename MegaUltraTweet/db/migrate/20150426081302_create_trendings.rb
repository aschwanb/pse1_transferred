class CreateTrendings < ActiveRecord::Migration
  def change
    create_table :trendings do |t|

      t.timestamps null: false
    end
  end
end
