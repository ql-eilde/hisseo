class RemoveImageFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :profile_img
  end
end
