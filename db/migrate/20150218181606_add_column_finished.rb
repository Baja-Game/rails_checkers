class AddColumnFinished < ActiveRecord::Migration
  def up
    add_column :games, :finished, :boolean
  end
end
