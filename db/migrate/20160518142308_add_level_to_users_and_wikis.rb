class AddLevelToUsersAndWikis < ActiveRecord::Migration
  def change
    add_column :users, :level, :integer, default: 1
    add_column :wikis, :level, :integer, default: 1
  end
end
