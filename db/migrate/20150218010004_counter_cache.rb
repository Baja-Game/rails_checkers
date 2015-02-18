class CounterCache < ActiveRecord::Migration
  def change
    add_column :games, :game_users_count, :integer
  end
end
