class ChangeFinished < ActiveRecord::Migration
  def change
    change_column :games, :finished, :integer
  end
end
