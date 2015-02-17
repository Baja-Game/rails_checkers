class Games < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :board
      t.integer :turn_counter
      t.timestamps null: false
    end
  end
end
