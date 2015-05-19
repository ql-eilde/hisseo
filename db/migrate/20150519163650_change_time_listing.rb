class ChangeTimeListing < ActiveRecord::Migration
  def change
  	remove_column :listings, :time_hour, :integer
  	remove_column :listings, :time_minute, :integer
  	add_column :listings, :time, :string
  end
end
