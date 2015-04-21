class AddDefaultsToPopulirities < ActiveRecord::Migration
  def change
    change_column :popularities, :new, :boolean, default: true
    change_column :popularities, :now, :integer, default: 0
    change_column :popularities, :old_1, :integer, default: 0
    change_column :popularities, :old_2, :integer, default: 0
    change_column :popularities, :old_3exit, :integer, default: 0
  end
end
