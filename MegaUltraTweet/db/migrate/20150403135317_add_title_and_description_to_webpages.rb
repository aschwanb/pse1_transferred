class AddTitleAndDescriptionToWebpages < ActiveRecord::Migration
  def change
    add_column :webpages, :title, :string
    add_column :webpages, :description, :string
  end
end
