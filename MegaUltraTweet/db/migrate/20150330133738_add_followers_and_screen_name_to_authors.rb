class AddFollowersAndScreenNameToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :followers_count, :integer
    add_column :authors, :screen_name, :string
  end
end
