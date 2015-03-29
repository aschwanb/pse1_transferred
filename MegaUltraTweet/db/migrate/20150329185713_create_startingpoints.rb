class CreateStartingpoints < ActiveRecord::Migration
  def change
    create_table :startingpoints do |t|

      t.timestamps null: false
    end
  end
end
