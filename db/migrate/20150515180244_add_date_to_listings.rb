class AddDateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :date, :string
  end
end
