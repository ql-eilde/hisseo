class AddCguToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cgu, :boolean
  end
end
