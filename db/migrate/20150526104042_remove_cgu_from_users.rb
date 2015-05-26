class RemoveCguFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :cgu, :boolean
  end
end
