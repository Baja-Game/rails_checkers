class AddColumnFinished < ActiveRecord::Migration
  def up
    add_column :games, :finished, :integer
  end
end
