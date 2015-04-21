class CreatePopularities < ActiveRecord::Migration
  def change
    create_table :popularities do |t|
      t.boolean :new
      t.integer :now
      t.integer :old_1
      t.integer :old_2
      t.integer :old_3
      t.references :popular, polimorphic: true, index: true

      t.timestamps null: false
    end
  end
end
