class AddStatsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wins, :integer, default: 0
    add_column :users, :losses, :integer, default: 0
    add_column :users, :forfeits, :integer, default: 0
    add_column :users, :ranking, :integer
  end
end
