class CaptureCounter < ActiveRecord::Migration
  def change
    add_column :games, :capture_counter, :integer, default: 40
  end
end
