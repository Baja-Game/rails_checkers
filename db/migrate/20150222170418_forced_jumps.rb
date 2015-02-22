class ForcedJumps < ActiveRecord::Migration
  def change
    add_column :games, :forced_jumps, :boolean, default: true
  end
end
