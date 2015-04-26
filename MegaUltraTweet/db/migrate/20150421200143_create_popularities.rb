class CreatePopularities < ActiveRecord::Migration
  def change
    create_table :popularities do |t|
      t.references  :popular, polimorphic: true, index: true
      t.string      :popular_type
      t.text        :usage

      t.timestamps null: false
    end
  end
end
