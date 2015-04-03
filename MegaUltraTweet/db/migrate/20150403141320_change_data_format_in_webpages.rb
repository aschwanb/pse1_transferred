class ChangeDataFormatInWebpages < ActiveRecord::Migration
  def change
    change_column :webpages, :description, :text
  end
end
