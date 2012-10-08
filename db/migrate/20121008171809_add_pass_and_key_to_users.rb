class AddPassAndKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pass, :integer
    add_column :users, :key, :integer
  end
end
