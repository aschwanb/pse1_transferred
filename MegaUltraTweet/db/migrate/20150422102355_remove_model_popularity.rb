class RemoveModelPopularity < ActiveRecord::Migration
  def change
    drop_table :popularities
  end
end
