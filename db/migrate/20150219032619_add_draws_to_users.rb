class AddDrawsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :draws, :integer, default: 0
    remove_column :users, :ranking
    add_column :users, :experience, :integer, default: 0
  end
end
