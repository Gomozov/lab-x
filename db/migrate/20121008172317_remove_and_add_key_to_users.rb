class RemoveAndAddKeyToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :key
  end

  def down
    add_column :users, :key, :string
  end
end
