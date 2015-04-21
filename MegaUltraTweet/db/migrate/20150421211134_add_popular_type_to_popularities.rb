class AddPopularTypeToPopularities < ActiveRecord::Migration
  def change
    add_column :popularities, :popular_type, :string
  end
end
