class ThemeColumn < ActiveRecord::Migration
  def change
    add_column :users, :theme, :string, default: 'none'
  end
end
