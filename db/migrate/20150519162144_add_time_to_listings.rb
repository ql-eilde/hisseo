class AddTimeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :time_hour, :integer
    add_column :listings, :time_minute, :integer
  end
end
